import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../theme/theme_constants.dart';
import '../../../utils/navigation.dart';

/// Widget, defines text and button when no task has been added to the app.
class TasksNotAddedYetWidget extends StatelessWidget {
  /// Constructor for [TasksNotAddedYetWidget].
  const TasksNotAddedYetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(emptyTasksPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(context.l10n.tasksNotAddedYet),
          ),
          TextButton(
            onPressed: () {
              Navigation.navigateToTaskEditor(context);
            },
            child: Text(context.l10n.orPressThisButton),
          ),
        ],
      ),
    );
  }
}
