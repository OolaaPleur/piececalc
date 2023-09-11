import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:piececalc/data/datasources/work_data_source.dart';
import 'package:piececalc/utils/database/database_operations.dart';

import '../../../data/models/work.dart';
import '../../../data/repositories/work_repository.dart';

/// Abstract base state for the `AddWork` functionality.
abstract class AddWorkState {}

/// Represents the initial state for the `AddWork` page.
/// Typically, this state is set when the page is first loaded.
class AddWorkInitial extends AddWorkState {}

/// Represents the state when a work is being saved.
/// This can be useful to show loading animations or indicators to the user.
class WorkSaving extends AddWorkState {}

/// Represents the state after a work has been successfully saved.
/// Used to give feedback to the user, like showing a success message.
class WorkSaved extends AddWorkState {}

/// Represents the state when multiple works are being loaded.
/// Useful to indicate to the user that data is currently being fetched.
class WorksLoading extends AddWorkState {}

/// Represents the state after multiple works have been successfully loaded.
class WorksLoaded extends AddWorkState {
  /// Creates a [WorksLoaded] state with the provided list of works.
  WorksLoaded(this.workData);

  /// [workData] contains the loaded list of works.
  final List<Work> workData;
}

/// Represents the state when a specific work is being deleted.
/// Useful to indicate to the user that a deletion process is ongoing.
class WorkDeleting extends AddWorkState {}

/// Represents the state after a specific work task has been successfully deleted.
/// Used to give feedback to the user, like showing a deletion success message.
class WorkDeleted extends AddWorkState {}

/// Represents the state when a work task cannot be deleted.
/// This can be due to fact that task with that work was created
/// and because of that it cant be deleted.
class WorkCantBeDeleted extends AddWorkState {}

/// Represents the state when a work task can be deleted.
/// We need to have it to know, do app needs to show snackbar that item
/// cant be deleted or show alert dialog with confirmation of deletion.
class WorkCanBeDeleted extends AddWorkState {
  /// Creates a [WorkCanBeDeleted] state with the provided work to delete.
  WorkCanBeDeleted(this.workToDelete);
  /// Works that user wants to delete.
  final Work workToDelete;
}

/// Represents a state indicating an error while performing work-related operations.
class WorkError extends AddWorkState {
  /// Creates a [WorkError] state with the provided error message.
  WorkError(this.error);

  /// [error] contains a descriptive message of what went wrong.
  final String error;
}

/// A [Cubit] that handles the logic and state management for adding work tasks.
///
/// It interacts with the [WorkDataSource] to perform CRUD operations.
class AddWorkCubit extends Cubit<AddWorkState> {
  /// Creates an instance of [AddWorkCubit].
  ///
  /// Initially, it sets the state to [AddWorkInitial].
  AddWorkCubit()
      : _workRepository = GetIt.I<WorkDataSource>(),
        super(AddWorkInitial());

  final WorkRepository _workRepository;

  /// Saves a given set of [data] related to a work task.
  ///
  /// If [isEditing] is set to true, it will attempt to update an existing work task. Otherwise, it will insert a new work task.
  /// After saving the data, it will refresh the list of works.
  ///
  /// [data] contains the details of the work to save or update.
  Future<void> saveData(Map<String, dynamic> data, {bool isEditing = false}) async {
    emit(WorkSaving());
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    if (isEditing) {
      await db.update('works', data, where: 'id = ?', whereArgs: [data['id']]);
    } else {
      await db.insert('works', data);
    }
    emit(WorkSaved());
    await loadWorks();
  }

  /// Loads all available works.
  ///
  /// Upon successful retrieval, it emits the [WorksLoaded] state with the list of works.
  Future<void> loadWorks() async {
    emit(WorksLoading());
    final savedWorks = await _workRepository.loadWorks();
    emit(WorksLoaded(savedWorks));
    //await DatabaseOperations.closeDatabase(db);
  }

  /// Check if work could be deleted.
  Future<void> checkDeletionPossibility (Work workToDelete) async {
    final db = await DatabaseOperations.openAppDatabase('piececalc');
    try {
      // Check if the work to delete exists in the 'done_works' table
      final doneWorksResult =
      await db.query('done_works', where: 'workId = ?', whereArgs: [workToDelete.id]);

      final worksQueryResult = await db.query('works');
      final works = worksQueryResult.map(Work.fromJson).toList();
      // If the work exists in 'done_works', we can't delete it from 'works'
      if (doneWorksResult.isNotEmpty) {
        emit(WorkCantBeDeleted());
        emit(WorksLoaded(works));
        return;
      } else {
        emit(WorkCanBeDeleted(workToDelete));
        emit(WorksLoaded(works));
      }
    } catch (error) {
      // Handle the database error. This could be logging the error, showing a user-friendly message, etc.
      emit(
        WorkError(error.toString()),
      ); // Assuming you have an ErrorState or similar to emit errors.
    }
  }

  /// Deletes a specific work task.
  ///
  /// [workToDelete] specifies the work task that needs to be removed.
  Future<void> deleteWork(Work workToDelete) async {
    emit(WorkDeleting());
    final db = await DatabaseOperations.openAppDatabase('piececalc');

    try {
      // Check if the work to delete exists in the 'done_works' table
      final doneWorksResult =
          await db.query('done_works', where: 'workId = ?', whereArgs: [workToDelete.id]);

      // If the work exists in 'done_works', we can't delete it from 'works'
      if (doneWorksResult.isNotEmpty) {
        emit(WorkCantBeDeleted());
        final worksQueryResult = await db.query('works');
        final works = worksQueryResult.map(Work.fromJson).toList();
        emit(WorksLoaded(works));
        return;
      }

      // If we reached here, the work doesn't exist in 'done_works', so delete it from 'works'
      await db.delete('works', where: 'id = ?', whereArgs: [workToDelete.id]);

      // Emit states and updated works list
      emit(WorkDeleted());
      final updatedWorksQueryResult = await db.query('works');
      final updatedWorks = updatedWorksQueryResult.map(Work.fromJson).toList();
      emit(WorksLoaded(updatedWorks));
    } catch (error) {
      // Handle the database error. This could be logging the error, showing a user-friendly message, etc.
      emit(
        WorkError(error.toString()),
      ); // Assuming you have an ErrorState or similar to emit errors.
    }
  }
}
