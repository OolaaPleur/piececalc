import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/home/task_editor/bloc/task_editor_bloc.dart';
import '../screens/home/task_editor/task_editor.dart';

/// Class, defines different naavigations functions.
class Navigation {
  /// Navigate to [TaskEditor].
  static void navigateToTaskEditor(BuildContext context) {
    context.read<TaskEditorBloc>().add(LoadWorkEvent());
    context.read<TaskEditorBloc>().add(TaskEditorCreateTextField());
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const TaskEditor(),
      ),
    );
  }
}
