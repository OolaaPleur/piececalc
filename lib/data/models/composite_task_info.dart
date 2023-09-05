import 'package:equatable/equatable.dart';
import 'package:piececalc/data/models/work.dart';

import 'completed_task.dart';

/// Represents a composite information combining details of a [CompletedTask] with its associated [Work].
///
/// This class provides a consolidated view of a task that has been completed and the type of work it pertains to.
class CompositeTaskInfo extends Equatable {

  /// Creates a new instance of [CompositeTaskInfo].
  ///
  /// Requires a [completedTask] representing the completed task details and a [work] representing the associated type of work.
  const CompositeTaskInfo({required this.completedTask, required this.work});

  /// The completed task details.
  final CompletedTask completedTask;

  /// The associated type of work details.
  final Work work;

  @override
  List<Object?> get props => [completedTask, work];
}
