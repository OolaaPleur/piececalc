import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../../data/models/composite_task_info.dart';
import '../../../../theme/theme_constants.dart';
import '../../../tasks/tasks_bloc.dart';

/// Widget, shows button for task deletion.
class DeleteTask extends StatelessWidget {
  /// Constructor for [DeleteTask].
  const DeleteTask({super.key, this.editedObject, this.workData});

  /// Object. Needed to know what to delete.
  final CompositeTaskInfo? editedObject;

  /// List of all tasks, needed because we need to load them again.
  final Map<String, List<CompositeTaskInfo>>? workData;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: textFieldHorizontalPadding,
            vertical: textFieldVerticalPadding,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error, foregroundColor: Colors.white),
            onPressed: () {
              final cti = editedObject!;
              showAlertDialog(context, cti);
            },
            child: Text(context.l10n.deleteTask),
          ),
        );
      },
    );
  }

  /// Show alert dialog for deletion.
  void showAlertDialog(BuildContext context, CompositeTaskInfo compositeTaskInfo) {
    // set up the buttons
    final Widget cancelButton = TextButton(
      child: Text(context.l10n.yes),
      onPressed: () {
        context.read<TasksCubit>().deleteTask(workData!, compositeTaskInfo);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    final Widget continueButton = TextButton(
      child: Text(context.l10n.no),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    final alert = AlertDialog(
      title: Text(context.l10n.taskDeletion),
      content: Text(context.l10n.wouldYouLikeToDeleteThisTask),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
