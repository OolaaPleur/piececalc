import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../../theme/theme_constants.dart';

/// Widget, that defines button, which function is to remove group of fields.
class RemoveFieldButton extends StatelessWidget {
  /// Constructor for [RemoveFieldButton].
  const RemoveFieldButton({required this.onRemove, super.key});
  /// Callback for removing fields.
  final VoidCallback onRemove;

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
            onPressed: onRemove,
            child: Text(context.l10n.removeField),
          ),
        );
      },
    );
  }
}
