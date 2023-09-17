part of 'task_editor_bloc.dart';

/// Represents different events associated with the task editor.
abstract class TaskEditorEvent {}

/// An event that signifies the need to load works from database.
class LoadWorkEvent extends TaskEditorEvent {}

/// An event that triggers the saving mechanism for completed work.
class SaveTaskEvent extends TaskEditorEvent {
  /// Creates a [SaveTaskEvent].
  ///
  /// The [workData] provides details about the work.
  /// The [isEditing] denotes if the current operation is editing an existing entry.
  SaveTaskEvent(this.workData, {required this.isEditing});

  /// The details of the work that's being saved.
  final List<Map<String, dynamic>> workData;

  /// A flag to determine if the event is to edit an existing entry.
  final bool isEditing;
}

/// An event that clears all text fields.
class TaskEditorClearTextFields extends TaskEditorEvent {}

/// An event, deletes task.
class TaskEditorDeleteTask extends TaskEditorEvent {
  /// Constructor for [TaskEditorDeleteTask].
  TaskEditorDeleteTask({required this.groupedByDate, required this.compositeTaskInfo});

  /// Map, key is date in String format, values are [CompositeTaskInfo] for particular date.
  final Map<String, List<CompositeTaskInfo>> groupedByDate;
  /// Task, which needs to be deleted.
  final CompositeTaskInfo compositeTaskInfo;
}

/// An event, creates text fields.
class TaskEditorCreateTextField extends TaskEditorEvent {
  /// Constructor for [TaskEditorCreateTextField].
  TaskEditorCreateTextField();
}

/// An event, removes text field.
class TaskEditorRemoveTextField extends TaskEditorEvent {
  /// Constructor for [TaskEditorRemoveTextField].
  TaskEditorRemoveTextField({required this.group});

  /// Text field group, that needs to be removed.
  final TextFieldGroup group;
}
