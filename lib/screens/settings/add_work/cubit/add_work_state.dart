part of 'add_work_cubit.dart';

/// Abstract base state for the `AddWork` functionality.
abstract class AddWorkState {
  /// Constructor for [AddWorkState].
  AddWorkState({required this.workData});
  /// Contains list of loaded works.
  final List<Work> workData;
}

/// Represents the initial state for the `AddWork` page.
/// Typically, this state is set when the page is first loaded.
class AddWorkInitial extends AddWorkState {
  /// Constructor for [AddWorkInitial].
  AddWorkInitial({required super.workData});
}

/// Represents the state when a work is being saved.
/// This can be useful to show loading animations or indicators to the user.
class WorkSaving extends AddWorkState {
  /// Constructor for [WorkSaving].
  WorkSaving({required super.workData});
}

/// Represents the state after a work has been successfully saved.
/// Used to give feedback to the user, like showing a success message.
class WorkSaved extends AddWorkState {
  /// Constructor for [WorkSaved].
  WorkSaved({required super.workData});
}

/// Represents the state when multiple works are being loaded.
/// Useful to indicate to the user that data is currently being fetched.
class WorksLoading extends AddWorkState {
  /// Constructor for [WorksLoading].
  WorksLoading({required super.workData});
}

/// Represents the state after multiple works have been successfully loaded.
class WorksLoaded extends AddWorkState {
  /// Creates a [WorksLoaded] state with the provided list of works.
  WorksLoaded({required super.workData});
}

/// Represents the state when a specific work is being deleted.
/// Useful to indicate to the user that a deletion process is ongoing.
class WorkDeleting extends AddWorkState {
  /// Constructor for [WorkDeleting].
  WorkDeleting({required super.workData});
}

/// Represents the state after a specific work task has been successfully deleted.
/// Used to give feedback to the user, like showing a deletion success message.
class WorkDeleted extends AddWorkState {
  /// Constructor for [WorkDeleted].
  WorkDeleted({required super.workData});
}

/// Represents the state when a work task cannot be deleted.
/// This can be due to fact that task with that work was created
/// and because of that it cant be deleted.
class WorkCantBeDeleted extends AddWorkState {
  /// Constructor for [WorkCantBeDeleted].
  WorkCantBeDeleted({required super.workData});
}

/// Represents the state when a work task can be deleted.
/// We need to have it to know, do app needs to show snackbar that item
/// cant be deleted or show alert dialog with confirmation of deletion.
class WorkCanBeDeleted extends AddWorkState {
  /// Creates a [WorkCanBeDeleted] state with the provided work to delete.
  WorkCanBeDeleted(this.workToDelete, {required super.workData});

  /// Works that user wants to delete.
  final Work workToDelete;
}

/// Represents a state indicating an error while performing work-related operations.
class WorkError extends AddWorkState {
  /// Creates a [WorkError] state with the provided error message.
  WorkError(this.error, {required super.workData});

  /// [error] contains a descriptive message of what went wrong.
  final String error;
}
