// ignore_for_file: avoid_dynamic_calls

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:piececalc/constants/constants.dart';

import '../../data/datasources/work_data_source.dart';
import '../../data/models/completed_task.dart';
import '../../data/models/composite_task_info.dart';
import '../../data/models/work.dart';
import '../../data/models/work_summary.dart';
import '../../data/repositories/work_repository.dart';
import '../../utils/backup/backup_mobile.dart';
import '../../utils/backup/backup_web.dart';
import '../../utils/database/database_operations.dart';
import '../../utils/helpers.dart';

/// An abstract representation of the state of the `MonthlyWorkInfo` page.
///
/// This serves as a foundation for all specific states related to loading,
/// displaying, and manipulating monthly work information.
abstract class MonthlyWorkInfoState {
  /// Constructor for [MonthlyWorkInfoState].
  MonthlyWorkInfoState({required this.workData});

  /// Map containing the work items and their corresponding summaries.
  final Map<Work, WorkSummary> workData;
}

/// Represents the initial state of the `MonthlyWorkInfo` page.
///
/// Typically, this is the state before any data loading or operations have taken place.
class Initial extends MonthlyWorkInfoState {
  /// Constructor for [Initial].
  Initial() : super(workData: {});
}

/// Represents the state when the `MonthlyWorkInfo` data is being loaded.
class DataLoading extends MonthlyWorkInfoState {
  /// Constructor for [DataLoading].
  DataLoading({required super.workData});
}

/// Represents the state when the `MonthlyWorkInfo` data has been successfully loaded.
///
/// Contains a map of work items and their respective summaries.
class DataLoaded extends MonthlyWorkInfoState {
  /// Constructor for [DataLoaded].
  DataLoaded(this.compositeTaskInfo, {required super.workData, required this.month, required this.year, required this.completedTasks, required this.totalCombinedPrice});

  /// Composite object of 'Work' and 'Task', needed in case user
  /// wants to share data about current month work.
  final List<CompositeTaskInfo> compositeTaskInfo;
  /// Month, for which data is loaded.
  final int month;
  /// Year, for which data is loaded.
  final int year;
  /// List of completed tasks for this date period.
  final List<CompletedTask> completedTasks;
  /// Combined price for this date period.
  final double totalCombinedPrice;
}

/// Represents the state when a work item is being deleted from the `MonthlyWorkInfo`.
class Deleting extends MonthlyWorkInfoState {
  /// Constructor for [Deleting].
  Deleting({required super.workData});
}

/// Represents the state after a work item has been successfully deleted from the `MonthlyWorkInfo`.
class Deleted extends MonthlyWorkInfoState {
  /// Constructor for [Deleted].
  Deleted({required super.workData});
}

/// Represents an error state for the `MonthlyWorkInfo` page.
///
/// This state is typically invoked when there's an issue loading or manipulating data.
class DataError extends MonthlyWorkInfoState {
  /// Constructor for [DataError].
  DataError(this.error,{required super.workData});

  /// Detailed error message providing insights into what went wrong.
  final String error;
}

/// Manages the state and business logic related to monthly work information.
///
/// This cubit is responsible for loading work data from a database, processing it,
/// and emitting appropriate states to inform UI components of changes or updates.
class MonthlyWorkInfoCubit extends Cubit<MonthlyWorkInfoState> {
  /// Initializes the cubit with an [Initial] state.
  MonthlyWorkInfoCubit()
      : _workRepository = GetIt.I<WorkDataSource>(),
        super(Initial());

  final WorkRepository _workRepository;

  /// Asynchronously loads work data for a specific [month] and [year].
  ///
  /// The method will first emit a [DataLoading] state to indicate the start of data retrieval.
  /// Upon successful data fetching and processing, it emits a [DataLoaded] state containing
  /// a map of work summaries. If there's an error during this process, a [DataError] state is emitted.
  ///
  /// The work data is loaded based on entries from the 'done_works' and 'works' tables in the database.
  Future<void> loadData({required int month, required int year}) async {
    final log = Logger('MonthlyWorkInfoCubit_loadData');
    emit(DataLoading(workData: state.workData));
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
      final allWorks = await _workRepository.loadWorks();
      // Create a list of CompositeTaskInfo by combining TaskDone and Work based on workId
      final compositeTasks = completedTasks.map((doneWork) {
        final correspondingWork = allWorks.firstWhere((work) => work.id == doneWork.workId);
        return CompositeTaskInfo(completedTask: doneWork, work: correspondingWork);
      }).toList();

      var workSummaryByWorkId = <Work, WorkSummary>{};

// Introducing the new variable to store the total combined price of all tasks
      var totalCombinedPrice = 0.0;

      for (final composite in compositeTasks) {
        final work = composite.work;
        if (work.paymentType == PaymentType.piecewisePayment.toString().split('.').last) {
          final addedAmount = double.tryParse(composite.completedTask.amount) ?? 0.0;
          final workPrice = work.price;
          final combinedPrice = addedAmount * workPrice;

          totalCombinedPrice += combinedPrice; // Increment the total combined price

          if (!workSummaryByWorkId.containsKey(work)) {
            workSummaryByWorkId[work] =
                WorkSummary(amount: addedAmount.toString(), combinedPrice: combinedPrice);
          } else {
            final existingSummary = workSummaryByWorkId[work]!;
            final updatedAmount = (double.tryParse(existingSummary.amount) ?? 0.0) + addedAmount;
            final updatedCombinedPrice = existingSummary.combinedPrice + combinedPrice;

            workSummaryByWorkId[work] =
                WorkSummary(amount: updatedAmount.toString(), combinedPrice: updatedCombinedPrice);
          }
        } else if (work.paymentType == PaymentType.hourlyPayment.toString().split('.').last) {
          final timeString = composite.completedTask.amount;
          final hourlyRate = work.price;
          final earnings = Helpers.calculateEarnings(timeString, hourlyRate);

          totalCombinedPrice += earnings; // Increment the total combined price

          if (!workSummaryByWorkId.containsKey(work)) {
            workSummaryByWorkId[work] = WorkSummary(amount: timeString, combinedPrice: earnings);
          } else {
            final existingSummary = workSummaryByWorkId[work]!;

            // Convert both time strings into total minutes
            final existingMinutes = Helpers.timeToMinutes(existingSummary.amount);
            final newMinutes = Helpers.timeToMinutes(timeString);

            // Sum the minutes and convert them back to HH:mm format
            final updatedAmount = Helpers.minutesToTime(existingMinutes + newMinutes);

            final updatedCombinedPrice = existingSummary.combinedPrice + earnings;

            workSummaryByWorkId[work] =
                WorkSummary(amount: updatedAmount, combinedPrice: updatedCombinedPrice);
          }
        }
      }

      final sortedEntries = workSummaryByWorkId.entries.toList()
        ..sort((a, b) => b.value.combinedPrice.compareTo(a.value.combinedPrice));  // Sort descending by combinedPrice
      workSummaryByWorkId = Map.fromEntries(sortedEntries);

      if (compositeTasks.isEmpty) {
        emit(DataLoaded(workData: {}, month: month, year: year, [],completedTasks: [], totalCombinedPrice: 0));
        return;
      }
      emit(DataLoaded(workData: workSummaryByWorkId, month: month, year: year, compositeTasks, completedTasks: completedTasks, totalCombinedPrice: totalCombinedPrice));
    } catch (error) {
      log.log(Level.WARNING, error.toString());
      emit(DataError(error.toString(), workData: {}));
    }
  }

  /// Function, that creates backup.
  Future<void> createBackup(
    Map<Work, WorkSummary> workData,
    List<CompositeTaskInfo> compositeTaskInfo,
  {required String shareSubject,
      required String shareText,}
  ) async {
    final doneWorksCSV = _generateCSV(workData, compositeTaskInfo);
    if (kIsWeb) {
      await createAndShareBackupWeb(worksCSV: '', doneWorksCSV: doneWorksCSV, subject: shareSubject, text: shareText, fileName: 'monthBackup');
    } else {
      await createAndShareBackupMobile(worksCSV: '', doneWorksCSV: doneWorksCSV, subject: shareSubject, text: shareText, fileName: 'monthBackup');
    }
  }

  String _generateCSV(
    Map<Work, WorkSummary> workData,
    List<CompositeTaskInfo> compositeTaskInfo,
  ) {
    // Step 1: Grouping the data
    final dateToWorkToAmount = <String, Map<String, double>>{};

    for (final composite in compositeTaskInfo) {
      final date = composite.completedTask.dateCreated;
      final workName = composite.work.workName;
      final amount = composite.completedTask.amount;

      if (composite.work.paymentType == PaymentType.piecewisePayment.toString().split('.').last) {
        dateToWorkToAmount.putIfAbsent(date, () => {})[workName] =
            (dateToWorkToAmount[date]?[workName] ?? 0) + double.parse(amount);
      } else if (composite.work.paymentType == PaymentType.hourlyPayment.toString().split('.').last) {
        // Convert the amount from "hh:mm" format to total minutes
        final totalMinutes = Helpers.timeToMinutes(amount);

        // Update the map with minutes (you can convert it back to "hh:mm" format when needed)
        dateToWorkToAmount.putIfAbsent(date, () => {})[workName] =
            (dateToWorkToAmount[date]?[workName] ?? 0) + totalMinutes;
      }

    }

    // Step 2: Get unique work names
    final workNames = workData.keys.map((work) => work.workName).toSet().toList();

// Step 3: Generate rows for each date
    final rows = <List<String>>[];
    dateToWorkToAmount.forEach((date, workToAmount) {
      final row = <String>[date];
      for (final workName in workNames) {
        final type = workData.keys.firstWhere((work) => work.workName == workName).paymentType;
        if (type == PaymentType.hourlyPayment.toString().split('.').last) {
          // Convert minutes back to "hh:mm" format for hourly payments
          row.add(Helpers.minutesToTime(workToAmount[workName]?.toInt() ?? 0));
        } else {
          // For other types, use the double or int format
          row.add(workToAmount[workName]?.toString() ?? '0');
        }
      }
      rows.add(row);
    });


    // Sort rows by date
    rows.sort((a, b) => a[0].compareTo(b[0]));

// Step 4: Generate the "Total" row using WorkSummary
    final totalRow = <String>['Total'];
    for (final work in workData.keys) {
      totalRow.add(workData[work]!.amount);
    }

    // Step 5: Generate the "Total sum" row using WorkSummary
    final totalSumRow = <String>['Total sum'];
    for (final work in workData.keys) {
      totalSumRow.add(workData[work]!.combinedPrice.toString());
    }

// Step 6: Combine everything to generate the CSV
    final csv = StringBuffer()

    // Header
      ..writeln(['Date', ...workNames].join(','));

// Rows
    for (final row in rows) {
      csv.writeln(row.join(','));
    }

// Total and Total Sum Rows
    csv
      ..writeln(totalRow.join(','))  // Make sure to convert these rows' amounts to "hh:mm" format too if needed
      ..writeln(totalSumRow.join(','));

    return csv.toString();
  }
}
