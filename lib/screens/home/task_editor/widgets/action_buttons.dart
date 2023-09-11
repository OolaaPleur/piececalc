import 'package:flutter/material.dart';
import 'package:piececalc/screens/home/task_editor/widgets/remove_field_button.dart';

import '../../../../data/models/composite_task_info.dart';
import 'delete_task_button.dart';

/// Widget, defines two buttons, one deletes task (shows in editing mode)
/// and other removes set of fields (shows in creation mode).
class ActionButtons extends StatelessWidget {
  /// Constructor for [ActionButtons].
  const ActionButtons({
    required this.onRemove,
    required this.editedObject,
    required this.workData,
    super.key,
  });

  /// Edited task object.
  final CompositeTaskInfo? editedObject;

  /// Map of composite tasks as values and dates in string as keys.
  final Map<String, List<CompositeTaskInfo>>? workData;

  /// Callback, removes field.
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    if (editedObject != null) {
      return DeleteTask(editedObject: editedObject, workData: workData);
    } else {
      return RemoveFieldButton(onRemove: onRemove);
    }
  }
}
