import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:piececalc/data/datasources/work_data_source.dart';
import 'package:piececalc/utils/database/database_operations.dart';

import '../../../../data/models/work.dart';
import '../../../../data/repositories/work_repository.dart';

part 'add_work_state.dart';

/// A [Cubit] that handles the logic and state management for adding work tasks.
///
/// It interacts with the [WorkDataSource] to perform CRUD operations.
class AddWorkCubit extends Cubit<AddWorkState> {
  /// Creates an instance of [AddWorkCubit].
  ///
  /// Initially, it sets the state to [AddWorkInitial].
  AddWorkCubit()
      : _workRepository = GetIt.I<WorkDataSource>(),
        super(AddWorkInitial(workData: []));

  final WorkRepository _workRepository;

  /// Saves a given set of [data] related to a work task.
  ///
  /// If [isEditing] is set to true, it will attempt to update an existing work task. Otherwise, it will insert a new work task.
  /// After saving the data, it will refresh the list of works.
  ///
  /// [data] contains the details of the work to save or update.
  Future<void> saveData(Map<String, dynamic> data, {bool isEditing = false}) async {
    emit(WorkSaving(workData: state.workData));
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    if (isEditing) {
      await db.update('works', data, where: 'id = ?', whereArgs: [data['id']]);
    } else {
      await db.insert('works', data);
    }
    emit(WorkSaved(workData: state.workData));
    await saveOrder(state.workData);
  }

  /// Loads all available works.
  ///
  /// Upon successful retrieval, it emits the [WorksLoaded] state with the list of works.
  Future<void> loadWorks() async {
    emit(WorksLoading(workData: state.workData));
    final workData = await _workRepository.loadWorks();
    emit(WorksLoaded(workData: workData));
  }

  /// Saves order of items.
  Future<void> saveOrder(List<Work> savedWorks) async {
    final db = await DatabaseOperations.openAppDatabase('piececalc');
    // Begin a transaction to ensure data consistency
    await db.transaction((txn) async {
      for (final item in savedWorks) {
        await txn.update(
          'works',
          {'orderIndex': item.orderIndex}, // Update the order_index column
          where: 'id = ?', // Assuming you have an ID column to uniquely identify items
          whereArgs: [item.id],
        );
      }
    });
    final updatedWorks = await _workRepository.loadWorks();
    emit(WorksLoaded(workData: updatedWorks));
  }

  /// Check if work could be deleted.
  Future<void> checkDeletionPossibility(Work workToDelete) async {
    final db = await DatabaseOperations.openAppDatabase('piececalc');
    try {
      // Check if the work to delete exists in the 'done_works' table
      final doneWorksResult =
          await db.query('done_works', where: 'workId = ?', whereArgs: [workToDelete.id]);
      // If the work exists in 'done_works', we can't delete it from 'works'
      if (doneWorksResult.isNotEmpty) {
        emit(WorkCantBeDeleted(workData: state.workData));
        emit(WorksLoaded(workData: state.workData));
        return;
      } else {
        emit(WorkCanBeDeleted(workData: state.workData, workToDelete));
        emit(WorksLoaded(workData: state.workData));
      }
    } catch (error) {
      // Handle the database error. This could be logging the error, showing a user-friendly message, etc.
      emit(
        WorkError(workData: state.workData, error.toString()),
      ); // Assuming you have an ErrorState or similar to emit errors.
    }
  }

  /// Deletes a specific work task.
  ///
  /// [workToDelete] specifies the work task that needs to be removed.
  Future<void> deleteWork(Work workToDelete) async {
    emit(WorkDeleting(workData: state.workData));
    final db = await DatabaseOperations.openAppDatabase('piececalc');

    try {
      // Check if the work to delete exists in the 'done_works' table
      final doneWorksResult =
          await db.query('done_works', where: 'workId = ?', whereArgs: [workToDelete.id]);


      // If the work exists in 'done_works', we can't delete it from 'works'
      if (doneWorksResult.isNotEmpty) {
        emit(WorkCantBeDeleted(workData: state.workData));

        emit(WorksLoaded(workData: state.workData));
        return;
      }

      // If we reached here, the work doesn't exist in 'done_works', so delete it from 'works'
      await db.delete('works', where: 'id = ?', whereArgs: [workToDelete.id]);
      final updatedWorksQueryResult = await db.query('works');
      final updatedWorks = updatedWorksQueryResult.map(Work.fromJson).toList();
      // Emit states and updated works list
      emit(WorkDeleted(workData: updatedWorks));
      emit(WorksLoaded(workData: updatedWorks));
    } catch (error) {
      // Handle the database error. This could be logging the error, showing a user-friendly message, etc.
      emit(
        WorkError(workData: state.workData, error.toString()),
      ); // Assuming you have an ErrorState or similar to emit errors.
    }
  }

  /// Archive or unarchive work.
  Future<void> archiveWork(Work workToArchive, {required bool isArchiving}) async {
    final log = Logger('AddWorkCubit_archiveWork');
    final db = await DatabaseOperations.openAppDatabase('piececalc');
    try {
      await db.update('works', {'isArchived': isArchiving ? 1 : 0},
          where: 'id = ?', whereArgs: [workToArchive.id],);
    } catch (error) {
      log.log(Level.WARNING, 'Error updating work: $error');
    } finally {
      final worksQueryResult = await db.query('works');
      final works = worksQueryResult.map(Work.fromJson).toList();
      emit(WorksLoaded(workData: works));
    }
  }
}
