part of 'task_editor_bloc.dart';
/// Represents different states that the task editor can be in.
abstract class TaskEditorState {
  /// Constructor for [TaskEditorState].
  TaskEditorState({required this.textFieldGroup, required this.workData});

  /// The loaded work details.
  final List<Work> workData;

  /// List of text field groups.
  final List<TextFieldGroup> textFieldGroup;
}

/// Initial state of the task editor.
class TaskEditorInitial extends TaskEditorState {
  /// Constructor for [TaskEditorInitial].
  TaskEditorInitial({required super.textFieldGroup, required super.workData});
}

/// State, when task deleted (in edit mode).
class TaskEditorDeleted extends TaskEditorState {
  /// Constructor for [TaskEditorDeleted].
  TaskEditorDeleted({required super.textFieldGroup, required super.workData});
}

/// State after a completed work has been successfully saved.
class TaskSaved extends TaskEditorState {
  /// Constructor for [TaskSaved].
  TaskSaved({required super.textFieldGroup, required super.workData});
}

/// State when the work details are loaded.
class TaskEditorWorksLoaded extends TaskEditorState {
  /// Creates a [TaskEditorWorksLoaded] state with the provided [workData].
  TaskEditorWorksLoaded({required super.textFieldGroup, required super.workData});
}

/// State when there's an error in any operation in the task editor.
class TaskEditorError extends TaskEditorState {
  /// Creates a [TaskEditorError] state with a specific error [message].
  TaskEditorError(this.message, {required super.textFieldGroup, required super.workData});

  /// Message describing the error.
  final String message;
}
