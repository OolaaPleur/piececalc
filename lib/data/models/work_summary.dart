import 'package:equatable/equatable.dart';

/// Represents a summary of work completed.
///
/// Contains aggregated information such as the total amount of work
/// and the combined price associated with that work.
class WorkSummary extends Equatable {

  /// Creates a new instance of [WorkSummary].
  ///
  /// Requires [amount] representing the total units of work (e.g., hours or pieces)
  /// and [combinedPrice] representing the total monetary value of the work.
  const WorkSummary({required this.amount, required this.combinedPrice});

  /// The total amount or units of work.
  final String amount;

  /// The combined monetary value of the work.
  final double combinedPrice;

  @override
  List<Object> get props => [amount, combinedPrice];
}
