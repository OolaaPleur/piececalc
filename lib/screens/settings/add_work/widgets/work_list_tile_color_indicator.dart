import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

/// Defines color indicator on work tile.
class WorkListTileColorIndicator extends StatelessWidget {
  /// Constructor for [WorkListTileColorIndicator].
  const WorkListTileColorIndicator({
    required this.workColor, super.key,
  });

  /// Color of work.
  final Color workColor;

  @override
  Widget build(BuildContext context) {
    return ColorIndicator(
      width: 30,
      height: 30,
      borderRadius: 100,
      color: workColor,
      onSelectFocus: false,
    );
  }
}
