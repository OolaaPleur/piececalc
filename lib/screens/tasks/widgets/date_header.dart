import 'package:flutter/material.dart';
import 'package:piececalc/theme/theme_constants.dart';

import '../../../utils/helpers.dart';

/// Widget, defines data in tasks header.
class DateHeader extends StatelessWidget {
  /// Constructor for [DateHeader].
  const DateHeader({
    required this.date, super.key,
  });

  /// Date in yyyy-MM-dd format.
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(listTilePadding),
      child: Text(
        Helpers.formatDataToHumanReadable(date, context),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        ),
      ),
    );
  }
}
