// ignore_for_file: avoid_dynamic_calls
import 'package:bloc/bloc.dart';
import 'package:piececalc/data/models/completed_task.dart';

import '../../data/models/composite_task_info.dart';
import '../../data/models/work.dart';
import '../../utils/database/database_operations.dart';

/// An abstract representation of the different states the 'Tasks' page can be in.
abstract class TasksState {}

/// The initial state for the 'Tasks' page before any tasks have been loaded.
class TasksInitial extends TasksState {}

/// Represents the state of the 'Tasks' page while the tasks are being loaded.
class TasksLoading extends TasksState {}

/// Represents the state of the 'Tasks' page when tasks have been loaded and are ready for display.
/// associated with the tasks.
class TasksLoaded extends TasksState {
  /// Creates a [TasksLoaded] state with the provided task data.
  TasksLoaded(this.taskData);

  /// [taskData] contains a map of all the tasks and their details.
  final Map<String, List<CompositeTaskInfo>> taskData;
}

/// Represents the state when the tasks are in the process of being deleted.
class TaskDeleting extends TasksState {}

/// Represents the state after the tasks have been successfully deleted.
class TaskDeleted extends TasksState {}

/// Represents an error state for the tasks, capturing any errors that might have occurred.
class TasksError extends TasksState {

  /// Creates a [TasksError] state with the provided error message.
  TasksError(this.error);
  /// [error] contains a descriptive error message detailing the nature of the error.
  final String error;
}

/// Manages the state and logic for the 'Tasks' page.
///
/// Responsible for loading tasks, handling task deletions, and managing any errors.
class TasksCubit extends Cubit<TasksState> {

  /// Initializes the [TasksCubit] with the [TasksInitial] state.
  TasksCubit() : super(TasksInitial());

  /// Asynchronously loads the tasks data.
  ///
  /// This method fetches the tasks from a data source and
  /// updates the state accordingly, either to [TasksLoaded]
  /// on success or [TasksError] on failure.
  Future<void> loadData() async {
    emit(TasksLoading());
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');
    try {
      // Fetch all rows from the 'done_works' table
      final List<Map<String, dynamic>> doneWorksResult = await db.query('done_works');
      final doneWorks = doneWorksResult.map(CompletedTask.fromJson).toList();
      // Fetch all rows from the 'works' table
      final List<Map<String, dynamic>> allWorksResult = await db.query('works');
      final allWorks = allWorksResult.map(Work.fromJson).toList();
      // Create a list of CompositeTaskInfo by combining TaskDone and Work based on workId
      final completedTasks = doneWorks.map((doneWork) {
        final correspondingWork = allWorks.firstWhere((work) => work.id == doneWork.workId);
        return CompositeTaskInfo(completedTask: doneWork, work: correspondingWork);
      }).toList();

      final groupedByDate = <String, List<CompositeTaskInfo>>{};

      for (final taskInfo in completedTasks) {
        final date = taskInfo.completedTask.dateCreated;
        if (groupedByDate.containsKey(date)) {
          groupedByDate[date]!.add(taskInfo);
        } else {
          groupedByDate[date] = [taskInfo];
        }
      }

      final sortedDates = groupedByDate.keys.toList()
        ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));

      final sortedGroupedByDate = <String, List<CompositeTaskInfo>>{};

      for (final date in sortedDates) {
        sortedGroupedByDate[date] = groupedByDate[date]!;
      }

      emit(TasksLoaded(sortedGroupedByDate));
    } catch (error) {
      // Handle the database error. This could be logging the error, emitting an error state, etc.
      emit(TasksError(error.toString())); // Assuming you have an ErrorState or something similar.
    }
  }
  /// Deletes task.
  ///
  /// This method deletes task from a data source and
  /// updates the state accordingly, either to [TaskDeleted]
  /// and after to [TasksLoaded] with remained tasks list
  /// on success or [TasksError] on failure.
  Future<void> deleteTask(
    Map<String, List<CompositeTaskInfo>> groupedByDate,
    CompositeTaskInfo compositeTaskInfo,
  ) async {
    final db = await DatabaseOperations.openAppDatabaseAndCreateTables('piececalc');

    try {
      // 1. Determine which date (key in the Map) the compositeTaskInfo belongs to.
      String? dateKey;
      for (final key in groupedByDate.keys) {
        if (groupedByDate[key]!.contains(compositeTaskInfo)) {
          dateKey = key;
          break;
        }
      }

      if (dateKey != null) {
        // 2. Remove the compositeTaskInfo from the list under that date.
        groupedByDate[dateKey]!.remove(compositeTaskInfo);

        // 3. If the list for that date becomes empty, then remove the date key itself from the map.
        if (groupedByDate[dateKey]!.isEmpty) {
          groupedByDate.remove(dateKey);
        }
      }

      // Deleting the task from the 'done_works' table
      await db.delete(
        'done_works',
        where: 'id = ?',
        whereArgs: [
          compositeTaskInfo.completedTask.id,
        ],
      ); // Assuming each TaskDone has a unique ID field.
      emit(TaskDeleted());
      emit(TasksLoaded(groupedByDate));
    } catch (error) {
      // Handle the database error. This could be logging the error, emitting an error state, etc.
      emit(
        TasksError(error.toString()),
      ); // Assuming you have an ErrorState or similar to emit errors.
    }
  }
}
