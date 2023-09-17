import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/home/task_editor/bloc/task_editor_bloc.dart';
import 'package:piececalc/screens/home/task_editor/text_field_group.dart';

import '../../../../theme/theme_constants.dart';

/// Widget, that defines button, which function is to remove group of fields.
class RemoveFieldButton extends StatelessWidget {
  /// Constructor for [RemoveFieldButton].
  const RemoveFieldButton({required this.groupToRemove, super.key});

  /// Defines group of text fields, which needs to be removed.
  final TextFieldGroup groupToRemove;

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
            onPressed: () {
              context.read<TaskEditorBloc>().add(TaskEditorRemoveTextField(group: groupToRemove));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            child: Text(context.l10n.removeField),
          ),
        );
      },
    );
  }
}
