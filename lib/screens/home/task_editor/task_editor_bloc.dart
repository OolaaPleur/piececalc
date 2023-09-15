import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:piececalc/screens/home/task_editor/text_field_group.dart';

import '../../../data/datasources/work_data_source.dart';
import '../../../data/models/composite_task_info.dart';
import '../../../data/models/work.dart';
import '../../../data/repositories/work_repository.dart';
import '../../../utils/database/database_operations.dart';

/// Represents different events associated with the task editor.
abstract class TaskEditorEvent {}

/// An event that signifies the need to load works from database.
class LoadWorkEvent extends TaskEditorEvent {}

/// An event that triggers the saving mechanism for completed work.
class SaveTaskEvent extends TaskEditorEvent {
  /// Creates a [SaveTaskEvent].
  ///
  /// The [workData] provides details about the work.
  /// The [isEditing] denotes if the current operation is editing an existing entry.
  SaveTaskEvent(this.workData, {required this.isEditing});

  /// The details of the work that's being saved.
  final List<Map<String, dynamic>> workData;

  /// A flag to determine if the event is to edit an existing entry.
  final bool isEditing;
}

class TaskEditorClearTextFields extends TaskEditorEvent {}

class TaskEditorDeleteTask extends TaskEditorEvent {
  TaskEditorDeleteTask({required this.groupedByDate, required this.compositeTaskInfo});

  final Map<String, List<CompositeTaskInfo>> groupedByDate;
  final CompositeTaskInfo compositeTaskInfo;
}

class TaskEditorCreateTextField extends TaskEditorEvent {
  TaskEditorCreateTextField();
}

class TasksEditorRemoveTextField extends TaskEditorEvent {
  TasksEditorRemoveTextField({required this.group});

  final TextFieldGroup group;
}

/// Represents different states that the task editor can be in.
abstract class TaskEditorState {
  TaskEditorState({required this.textFieldGroup, required this.workData});

  /// The loaded work details.
  final List<Work> workData;

  final List<TextFieldGroup> textFieldGroup;
}

/// Initial state of the task editor.
class TaskEditorInitial extends TaskEditorState {
  TaskEditorInitial({required super.textFieldGroup, required super.workData});
}

class TaskEditorDeleted extends TaskEditorState {
  TaskEditorDeleted({required super.textFieldGroup, required super.workData});
}

/// State after a completed work has been successfully saved.
class TaskSaved extends TaskEditorState {
  TaskSaved({required super.textFieldGroup, required super.workData});
}

/// State when the work details are loaded.
class TaskEditorWorksLoaded extends TaskEditorState {
  /// Creates a [TaskEditorWorksLoaded] state with the provided [workData].
  TaskEditorWorksLoaded({required super.textFieldGroup, required super.workData});
}

/// State when there's an error in any operation in the task editor.
class TaskEditorError extends TaskEditorState {
  /// Creates a [TaskEditorError] state with a specific error [message].
  TaskEditorError(this.message, {required super.textFieldGroup, required super.workData});

  /// Message describing the error.
  final String message;
}

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
    on<TasksEditorRemoveTextField>(_removeTextField);
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
      emit(TaskEditorError(
          textFieldGroup: state.textFieldGroup, workData: state.workData, error.toString(),),);
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
      emit(TaskSaved(
        textFieldGroup: state.textFieldGroup,
        workData: state.workData,
      ),);
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
      emit(TaskEditorInitial(
        textFieldGroup: [],
        workData: state.workData,
      ),);
    }
  }

  Future<void> _clearTextFields(
      TaskEditorClearTextFields event, Emitter<TaskEditorState> emit,) async {
    emit(TaskEditorInitial(
      textFieldGroup: [],
      workData: state.workData,
    ),);
  }

  Future<void> _createTextField(
      TaskEditorCreateTextField event, Emitter<TaskEditorState> emit,) async {
    final list = state.textFieldGroup..add(TextFieldGroup());
    emit(TaskEditorWorksLoaded(workData: state.workData, textFieldGroup: list));
  }

  Future<void> _removeTextField(
      TasksEditorRemoveTextField event, Emitter<TaskEditorState> emit,) async {
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
