import 'package:flutter/material.dart';
import 'package:piececalc/theme/theme.dart';

/// Widget, defines header and tooltip, used in addWork page and Chart page.
class HeaderAndTooltip extends StatelessWidget {
  /// Constructor for [HeaderAndTooltip].
  const HeaderAndTooltip({
    required this.tooltipKey, required this.title, required this.tooltipText, required this.isChart, super.key,
  });

  /// Key for tooltip.
  final GlobalKey<TooltipState> tooltipKey;
  /// Header text.
  final String title;
  /// Tooltip text.
  final String tooltipText;
  /// Checks where widget is draw, in addWork page or Chart page.
  final bool isChart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                      color: isChart ? context.color.moneyColor : null,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Tooltip(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                key: tooltipKey,
                triggerMode: TooltipTriggerMode.tap,
                showDuration: const Duration(seconds: 4),
                richMessage: WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: Text(
                      tooltipText,
                    ),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      // Adjust padding as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ), // Set your desired color and width
                      ),
                      child: Icon(
                        Icons.question_mark,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
