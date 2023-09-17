import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:piececalc/screens/home/task_editor/text_field_group.dart';
import '../../../../data/datasources/work_data_source.dart';
import '../../../../data/models/composite_task_info.dart';
import '../../../../data/models/work.dart';
import '../../../../data/repositories/work_repository.dart';
import '../../../../utils/database/database_operations.dart';

part 'task_editor_state.dart';

part 'task_editor_event.dart';

/// Bloc responsible for managing events and states of the task editor.
class TaskEditorBloc extends Bloc<TaskEditorEvent, TaskEditorState> {
  /// Constructs the [TaskEditorBloc].
  TaskEditorBloc()
      : _workRepository = GetIt.I<WorkDataSource>(),
        super(TaskEditorInitial(textFieldGroup: [], workData: [])) {
    on<LoadWorkEvent>(_loadWorks);
    on<SaveTaskEvent>(_saveTask);
    on<TaskEditorClearTextFields>(_clearTextFields);
    on<TaskEditorCreateTextField>(_createTextField);
    on<TaskEditorRemoveTextField>(_removeTextField);
    on<TaskEditorDeleteTask>(_deleteTask);
  }

  final WorkRepository _workRepository;

  Future<void> _loadWorks(LoadWorkEvent event, Emitter<TaskEditorState> emit) async {
    final log = Logger('LoadWorkEvent_loadWorks');
    try {
      final savedWorks = await _workRepository.loadWorks();
      emit(TaskEditorWorksLoaded(textFieldGroup: state.textFieldGroup, workData: savedWorks));
      log.log(Level.INFO, 'tasks loaded');
    } catch (error) {
      log.log(Level.WARNING, error.toString());
      emit(
        TaskEditorError(
          textFieldGroup: state.textFieldGroup,
          workData: state.workData,
          error.toString(),
        ),
      );
    }
  }

  Future<void> _saveTask(SaveTaskEvent event, Emitter<TaskEditorState> emit) async {
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    final log = Logger('SaveTaskEvent_saveTask');
    try {
      if (event.isEditing) {
        await db.update(
          'done_works',
          event.workData.first,
          where: 'id = ?',
          whereArgs: [event.workData.first['id']],
        );
      } else {
        await DatabaseOperations.insertDataBatch(db, 'done_works', event.workData);
      }
      emit(
        TaskSaved(
          textFieldGroup: state.textFieldGroup,
          workData: state.workData,
        ),
      );
    } catch (error) {
      log.log(Level.WARNING, error.toString());
      emit(
        TaskEditorError(
          textFieldGroup: state.textFieldGroup,
          workData: state.workData,
          error.toString(),
        ),
      );
    } finally {
      emit(
        TaskEditorInitial(
          textFieldGroup: [],
          workData: state.workData,
        ),
      );
    }
  }

  Future<void> _clearTextFields(
    TaskEditorClearTextFields event,
    Emitter<TaskEditorState> emit,
  ) async {
    emit(
      TaskEditorInitial(
        textFieldGroup: [],
        workData: state.workData,
      ),
    );
  }

  Future<void> _createTextField(
    TaskEditorCreateTextField event,
    Emitter<TaskEditorState> emit,
  ) async {
    final list = state.textFieldGroup..add(TextFieldGroup());
    emit(TaskEditorWorksLoaded(workData: state.workData, textFieldGroup: list));
  }

  Future<void> _removeTextField(
    TaskEditorRemoveTextField event,
    Emitter<TaskEditorState> emit,
  ) async {
    final list = state.textFieldGroup..remove(event.group);
    emit(TaskEditorWorksLoaded(workData: state.workData, textFieldGroup: list));
  }

  Future<void> _deleteTask(
    TaskEditorDeleteTask event,
    Emitter<TaskEditorState> emit,
  ) async {
    final log = Logger('TasksCubit_deleteTask');
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');

    try {
      // 1. Determine which date (key in the Map) the compositeTaskInfo belongs to.
      String? dateKey;
      for (final key in event.groupedByDate.keys) {
        if (event.groupedByDate[key]!.contains(event.compositeTaskInfo)) {
          dateKey = key;
          break;
        }
      }

      if (dateKey != null) {
        // 2. Remove the compositeTaskInfo from the list under that date.
        event.groupedByDate[dateKey]!.remove(event.compositeTaskInfo);

        // 3. If the list for that date becomes empty, then remove the date key itself from the map.
        if (event.groupedByDate[dateKey]!.isEmpty) {
          event.groupedByDate.remove(dateKey);
        }
      }

      // Deleting the task from the 'done_works' table
      await db.delete(
        'done_works',
        where: 'id = ?',
        whereArgs: [
          event.compositeTaskInfo.completedTask.id,
        ],
      ); // Assuming each TaskDone has a unique ID field.
      emit(TaskEditorDeleted(textFieldGroup: [], workData: state.workData));
    } catch (error) {
      log.log(Level.WARNING, error.toString());
      emit(
        TaskEditorError(
          error.toString(),
          textFieldGroup: state.textFieldGroup,
          workData: state.workData,
        ),
      );
    }
  }
}
