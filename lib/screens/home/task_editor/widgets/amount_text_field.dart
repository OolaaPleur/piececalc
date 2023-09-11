import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/theme_constants.dart';
import '../text_field_group.dart';

/// Defines widget, that shows amount text field.
class AmountTextField extends StatelessWidget {
/// Constructor for [AmountTextField].
  const AmountTextField({required this.group, required this.index, required this.textFieldGroups, super.key});
  /// [TextFieldGroup] objects with required controllers, focus nodes, and other params.
  final TextFieldGroup group;
  /// Index, needs to know where to give user focus.
  final int index;
  /// List of all [TextFieldGroup].
  final List<TextFieldGroup> textFieldGroups;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: textFieldHorizontalPadding,
        vertical: textFieldVerticalPadding,
      ),
      child: TextFormField(
        focusNode: group.amountFocusNode,
        keyboardType: TextInputType.number,
        controller: group.amountController,
        decoration:
        InputDecoration(labelText: context.l10n.workAmount),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return context.l10n.pleaseEnterAnAmount;
          }
          if (!numericPattern.hasMatch(value)) {
            return context.l10n.pleaseEnterAValidNumber;
          }
          return null;
        },
        onFieldSubmitted: (_) {
          if (index < textFieldGroups.length - 1) {
            group.amountFocusNode.unfocus();
            FocusScope.of(context).requestFocus(
              textFieldGroups[index + 1].typeAheadFocusNode,
            );
          } else {
            group.amountFocusNode.unfocus();
          }
        },
      ),
    );
  }
}
