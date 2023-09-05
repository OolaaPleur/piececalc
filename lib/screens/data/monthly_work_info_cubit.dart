// ignore_for_file: avoid_dynamic_calls

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

import '../../data/models/completed_task.dart';
import '../../data/models/composite_task_info.dart';
import '../../data/models/work.dart';
import '../../data/models/work_summary.dart';
import '../../utils/database/database_operations.dart';

/// An abstract representation of the state of the `MonthlyWorkInfo` page.
///
/// This serves as a foundation for all specific states related to loading,
/// displaying, and manipulating monthly work information.
abstract class MonthlyWorkInfoState {}

/// Represents the initial state of the `MonthlyWorkInfo` page.
///
/// Typically, this is the state before any data loading or operations have taken place.
class Initial extends MonthlyWorkInfoState {}

/// Represents the state when the `MonthlyWorkInfo` data is being loaded.
class Loading extends MonthlyWorkInfoState {}

/// Represents the state when the `MonthlyWorkInfo` data has been successfully loaded.
///
/// Contains a map of work items and their respective summaries.
class DataLoaded extends MonthlyWorkInfoState {
  /// Constructor for [DataLoaded].
  DataLoaded(this.workData, this.compositeTaskInfo);

  /// Map containing the work items and their corresponding summaries.
  final Map<Work, WorkSummary> workData;
  /// Composite object of 'Work' and 'Task', needed in case user
  /// wants to share data about current month work.
  final List<CompositeTaskInfo> compositeTaskInfo;
}

/// Represents the state when a work item is being deleted from the `MonthlyWorkInfo`.
class Deleting extends MonthlyWorkInfoState {}

/// Represents the state after a work item has been successfully deleted from the `MonthlyWorkInfo`.
class Deleted extends MonthlyWorkInfoState {}

/// Represents an error state for the `MonthlyWorkInfo` page.
///
/// This state is typically invoked when there's an issue loading or manipulating data.
class DataError extends MonthlyWorkInfoState {
  /// Constructor for [DataError].
  DataError(this.error);

  /// Detailed error message providing insights into what went wrong.
  final String error;
}

/// Manages the state and business logic related to monthly work information.
///
/// This cubit is responsible for loading work data from a database, processing it,
/// and emitting appropriate states to inform UI components of changes or updates.
class MonthlyWorkInfoCubit extends Cubit<MonthlyWorkInfoState> {
  /// Initializes the cubit with an [Initial] state.
  MonthlyWorkInfoCubit() : super(Initial());

  /// Asynchronously loads work data for a specific [month] and [year].
  ///
  /// The method will first emit a [Loading] state to indicate the start of data retrieval.
  /// Upon successful data fetching and processing, it emits a [DataLoaded] state containing
  /// a map of work summaries. If there's an error during this process, a [DataError] state is emitted.
  ///
  /// The work data is loaded based on entries from the 'done_works' and 'works' tables in the database.
  Future<void> loadData({required int month, required int year}) async {
    final log = Logger('MonthlyWorkInfoCubit_loadData');
    emit(Loading());
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    try {
      // Fetch all rows from the 'done_works' table
      final List<Map<String, dynamic>> completedTasksMap = await db.query(
        'done_works',
        where: "strftime('%Y-%m', dateCreated) = ?",
        whereArgs: ['$year-${month.toString().padLeft(2, '0')}'],
      );
      final completedTasks = completedTasksMap.map(CompletedTask.fromJson).toList();
      // Fetch all rows from the 'works' table
      final List<Map<String, dynamic>> allWorksMap = await db.query('works');
      final allWorks = allWorksMap.map(Work.fromJson).toList();
      // Create a list of CompositeTaskInfo by combining TaskDone and Work based on workId
      final compositeTasks = completedTasks.map((doneWork) {
        final correspondingWork = allWorks.firstWhere((work) => work.id == doneWork.workId);
        return CompositeTaskInfo(completedTask: doneWork, work: correspondingWork);
      }).toList();

      final workSummaryByWorkId = <Work, WorkSummary>{};

      for (final composite in compositeTasks) {
        final work = composite.work;
        final addedAmount = double.tryParse(composite.completedTask.amount) ?? 0.0;
        final workPrice = double.tryParse(work.price) ?? 0.0;
        final combinedPrice = addedAmount * workPrice;

        if (!workSummaryByWorkId.containsKey(work)) {
          workSummaryByWorkId[work] =
              WorkSummary(amount: addedAmount, combinedPrice: combinedPrice);
        } else {
          final existingSummary = workSummaryByWorkId[work]!;
          final updatedAmount = existingSummary.amount + addedAmount;
          final updatedCombinedPrice = existingSummary.combinedPrice + combinedPrice;

          workSummaryByWorkId[work] =
              WorkSummary(amount: updatedAmount, combinedPrice: updatedCombinedPrice);
        }
      }
      emit(DataLoaded(workSummaryByWorkId, compositeTasks));
    } catch (error) {
      log.log(Level.WARNING, 'error.toString()');
      emit(DataError(error.toString()));
    } finally {
      //await DatabaseOperations.closeDatabase(db);
    }
  }
}
