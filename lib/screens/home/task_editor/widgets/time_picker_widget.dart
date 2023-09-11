import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../../theme/theme_constants.dart';
import '../../../../utils/helpers.dart';
import '../text_field_group.dart';

/// Widget that defines time picker (if work is hourlyPayment).
class TimePickerWidget extends StatefulWidget {
  /// Constructor for [TimePickerWidget].
  const TimePickerWidget({required this.group, super.key});

  /// [TextFieldGroup] objects with required controllers, focus nodes, and other params.
  final TextFieldGroup group;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: timePickerPadding),
          child: Text(
            widget.group.time.format(context),
            style: TextStyle(fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: widget.group.time,
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
            );
            if (picked != null && picked != widget.group.time) {
              if (Helpers.isValidTime(picked)) {
                setState(() {
                  widget.group.time = picked;
                });
              }
            }
          },
          child: Text(context.l10n.selectTime),
        ),
      ],
    );
  }
}
