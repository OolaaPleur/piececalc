import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/tasks/tasks_helper.dart';

import '../../../data/models/composite_task_info.dart';
import '../../../theme/theme_constants.dart';
import '../../home/task_editor/bloc/task_editor_bloc.dart';

/// Widget defines how save and add new field buttons looks like.
class RowOfBottomFormButtons extends StatelessWidget {
  /// Constructor for [RowOfBottomFormButtons].
  const RowOfBottomFormButtons({
    required GlobalKey<FormState> formKey, required this.dateController, required this.editedObject, super.key,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  /// Contains date.
  final TextEditingController dateController;
  /// Edited object, if present.
  final CompositeTaskInfo? editedObject;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: textFieldHorizontalPadding,
            vertical: textFieldVerticalPadding,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: saveButtonHorizontalPadding,
                vertical: saveButtonVerticalPadding,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final fieldList = <Map<String, dynamic>>[];
                for (final textFields
                in context.read<TaskEditorBloc>().state.textFieldGroup) {
                  fieldList.add(
                    TasksHelper.convertDataFromTextFieldsIntoMap(
                      amount: textFields.amountController.text.trim(),
                      dateCreated: dateController.text.trim(),
                      workId: textFields.matchedWork!.id,
                      matchedWork: textFields.matchedWork!,
                      time: textFields.time,
                      context: context,
                      textFieldGroups:
                      context.read<TaskEditorBloc>().state.textFieldGroup,
                      editedObject: editedObject,
                      comment: textFields.commentController.text.trim(),
                    ),
                  );
                }
                if (editedObject == null) {
                  context
                      .read<TaskEditorBloc>()
                      .add(SaveTaskEvent(fieldList, isEditing: false));
                } else {
                  context
                      .read<TaskEditorBloc>()
                      .add(SaveTaskEvent(fieldList, isEditing: true));
                }
              }
            },
            child: Text(
              context.l10n.save,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
        ),
        if (editedObject == null)
          Expanded(
            child: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: textFieldHorizontalPadding,
                    vertical: textFieldVerticalPadding,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<TaskEditorBloc>()
                          .add(TaskEditorCreateTextField());
                    },
                    child: Text(
                      context.l10n.addNewField,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
