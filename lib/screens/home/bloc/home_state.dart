part of 'home_bloc.dart';

/// The base class for all states emitted by [HomeBloc].
abstract class HomeState {}

/// Represents the initial state for the [HomeBloc].
///
/// This state is emitted when the bloc is first created or reset.
class WorkDoneInitial extends HomeState {}

/// Represents the state when there are one or more tasks or works
/// that have been completed.
///
/// This state indicates that the user has completed some tasks and
/// there are records of such in the system.
class WorkDoneLengthMoreThanZero extends HomeState {}

/// Represents the state when no tasks or works have been completed.
///
/// This state indicates that the user hasn't completed any task and
/// there's no record of any completed task in the system.
class WorkDoneLengthEqualsZero extends HomeState {}

/// Represents an error state.
///
/// This state is emitted when there's an error processing tasks or works.
class WorkDoneError extends HomeState {
  /// Creates an error state with a descriptive error [message].
  WorkDoneError(this.message);

  /// Descriptive error message explaining what went wrong.
  final String message;
}
