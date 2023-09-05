// ignore_for_file: comment_references

import 'package:equatable/equatable.dart';

/// Represents a task that has been completed by the user.
///
/// Contains information about the task's ID, the associated work's ID,
/// the amount of work completed (e.g., hours or pieces), and the date the task was created.
class CompletedTask extends Equatable {

  /// Creates a new instance of [CompletedTask].
  ///
  /// Requires [id], [workId], [amount], and [dateCreated] to be provided.
  const CompletedTask({
    required this.id,
    required this.workId,
    required this.amount,
    required this.dateCreated,
  });

  /// Creates a new [CompletedTask] instance from a JSON map.
  factory CompletedTask.fromJson(Map<String, dynamic> json) {
    return CompletedTask(
      id: json['id'].toString(),
      workId: json['workId'].toString(),
      amount: json['amount'].toString(),
      dateCreated: json['dateCreated'].toString(),
    );
  }

  /// Unique identifier for the completed task.
  final String id;

  /// Identifier of the associated work from the [Work] class.
  final String workId;

  /// Amount of work completed, which could represent hours or pieces.
  final String amount;

  /// Date when the task was accomplished.
  final String dateCreated;

  @override
  List<Object> get props => [id, workId, amount, dateCreated];
}
