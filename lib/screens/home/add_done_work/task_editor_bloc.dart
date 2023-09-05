import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../../../data/datasources/work_data_source.dart';
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

/// Represents different states that the task editor can be in.
abstract class TaskEditorState {}

/// Initial state of the task editor.
class TaskEditorInitial extends TaskEditorState {}

/// State after a completed work has been successfully saved.
class TaskSaved extends TaskEditorState {}

/// State when the work details are loaded.
class WorksLoadedRefactorNextTime extends TaskEditorState {
  /// Creates a [WorksLoadedRefactorNextTime] state with the provided [workData].
  WorksLoadedRefactorNextTime(this.workData);

  /// The loaded work details.
  final List<Work> workData;
}

/// State when there's an error in any operation in the task editor.
class WorkDoneError extends TaskEditorState {
  /// Creates a [WorkDoneError] state with a specific error [message].
  WorkDoneError(this.message);

  /// Message describing the error.
  final String message;
}

/// Bloc responsible for managing events and states of the task editor.
class TaskEditorBloc extends Bloc<TaskEditorEvent, TaskEditorState> {
  /// Constructs the [TaskEditorBloc].
  TaskEditorBloc()
      : _workRepository = GetIt.I<WorkDataSource>(),
        super(TaskEditorInitial()) {
    on<LoadWorkEvent>(_loadWorks);
    on<SaveTaskEvent>(_saveTask);
  }

  final WorkRepository _workRepository;

  Future<void> _loadWorks(LoadWorkEvent event, Emitter<TaskEditorState> emit) async {
    final log = Logger('LoadWorkEvent_loadData');
    try {
      final savedWorks = await _workRepository.loadWorks();
      emit(WorksLoadedRefactorNextTime(savedWorks));
    } catch (error) {
      log.log(Level.WARNING, 'error.toString()');
      emit(WorkDoneError(error.toString()));
    }
  }

  Future<void> _saveTask(SaveTaskEvent event, Emitter<TaskEditorState> emit) async {
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    final log = Logger('SaveTaskEvent_loadData');
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
      emit(TaskSaved());
    } catch (error) {
      log.log(Level.WARNING, 'error.toString()');
      emit(
        WorkDoneError(
          error.toString(),
        ),
      );
    } finally {
      //await DatabaseOperations.closeDatabase(db);
      emit(TaskEditorInitial());
    }
  }
}
