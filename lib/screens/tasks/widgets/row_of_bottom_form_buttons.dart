import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../theme/theme_constants.dart';
import '../../../utils/helpers.dart';
import '../../home/task_editor/task_editor.dart';
import '../../home/task_editor/task_editor_bloc.dart';

class RowOfBottomFormButtons extends StatelessWidget {
  const RowOfBottomFormButtons({
    required GlobalKey<FormState> formKey, required this.dateController, required this.widget, super.key,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController dateController;
  final TaskEditor widget;

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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final fieldList = <Map<String, dynamic>>[];
                for (final textFields
                in context.read<TaskEditorBloc>().state.textFieldGroup) {
                  fieldList.add(
                    Helpers.convertDataFromTextFieldsIntoMap(
                      amount: textFields.amountController.text.trim(),
                      dateCreated: dateController.text.trim(),
                      workId: textFields.matchedWork!.id,
                      matchedWork: textFields.matchedWork!,
                      time: textFields.time,
                      context: context,
                      textFieldGroups:
                      context.read<TaskEditorBloc>().state.textFieldGroup,
                      editedObject: widget.editedObject,
                    ),
                  );
                }
                if (widget.editedObject == null) {
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
            child: Text(context.l10n.save),
          ),
        ),
        if (widget.editedObject == null)
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
