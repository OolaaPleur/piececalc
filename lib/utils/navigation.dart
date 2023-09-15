import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/home/task_editor/task_editor.dart';
import '../screens/home/task_editor/task_editor_bloc.dart';

class Navigation {
  static void navigateToTaskEditor(BuildContext context, ) {
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
