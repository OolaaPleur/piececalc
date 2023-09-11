import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:uuid/uuid.dart';

import '../constants/constants.dart';
import '../data/models/composite_task_info.dart';
import '../data/models/work.dart';
import '../screens/home/task_editor/text_field_group.dart';

/// Helpers functions.
class Helpers {
  /// Formats data into human readable format for tasks page date headers.
  static String formatDataToHumanReadable (String date, BuildContext context) {
    final parsedDate = DateTime.parse(date);
    final day = parsedDate.day;
    final weekday =
    daysOfWeekToLocalKey[DaysOfWeek.values[parsedDate.weekday - 1]]!(
      context.l10n,
    );
    final month =
    monthToLocalKey[Month.values[parsedDate.month - 1]]!(context.l10n, day);
    return '$day $month, $weekday';
  }
  /// Formats number as int (if has no fractional part) or leaves only two decimal points.
  static String formatNumber(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2); // Or more decimal places if needed.
    }
  }

  /// Calculates how much money made in specified time.
  static double calculateEarnings(String timeString, double hourlyRate) {
    // Split the string by ':' to get hours and minutes
    final parts = timeString.split(':');

    // Parse the hours and minutes
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    // Convert time to decimal hours
    final totalHours = hours + (minutes / 60.0);

    // Calculate earnings
    return totalHours * hourlyRate;
  }

  /// Format time duration into human-readable format.
  static String formatDuration(String timeString, BuildContext context) {

    final parts = timeString.split(':');
    if (parts.length != 2) return context.l10n.invalidFormat;

    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;

    if (hours == 0 && minutes == 0) {
      return context.l10n.minutesOnly(0);
    } else if (hours == 0) {
      return context.l10n.minutesOnly(minutes);
    } else if (minutes == 0) {
      return context.l10n.hoursOnly(hours);
    } else {
      return '${context.l10n.hoursOnly(hours)} ${context.l10n.minutesOnly(minutes)}';
    }
  }


  /// Convert minutes (presented in string) to integer.
  static int timeToMinutes(String timeString) {
    final parts = timeString.split(':');
    if (parts.length != 2) return 0;
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  /// Converts minutes (presented in integer) to string.
  static String minutesToTime(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Checks if valid time is picked.
  static bool isValidTime(TimeOfDay? time) {
    if (time == null) return false;
    return true;
  }

  /// Checks if any of textField has empty picked work.
  static bool checkIfThereIsEmptyPickedWork(List<TextFieldGroup> textFieldGroups) {
    var oneOfTaskHasEmptyPickedWork = false;
    for (final textFields in textFieldGroups) {
      if (textFields.matchedWork == null) {
        return oneOfTaskHasEmptyPickedWork = true;
      }
    }
    return oneOfTaskHasEmptyPickedWork;
  }

  /// Converts data to map, then it will be added to database.
  static Map<String, dynamic> convertDataFromTextFieldsIntoMap({
    required String amount,
    required String dateCreated,
    required String workId,
    required Work matchedWork,
    required TimeOfDay time,
    required BuildContext context, required List<TextFieldGroup> textFieldGroups, CompositeTaskInfo? editedObject,
  }) {
    String amountFormatted;
    if (matchedWork.paymentType == PaymentType.piecewisePayment.toString().split('.').last) {
      amountFormatted = amount.replaceAll(',', '.');
    } else if (matchedWork.paymentType == PaymentType.hourlyPayment.toString().split('.').last) {
      amountFormatted = time.format(context);
    } else {
      amountFormatted = amount;
    }
    if (editedObject != null) {
      final data = <String, dynamic>{
        'id': editedObject.completedTask.id,
        'workId': workId,
        'amount': amountFormatted,
        'dateCreated': dateCreated,
      };
      return data;
    } else {
      const uuid = Uuid();
      final uniqueKey = uuid.v1();
      if (!Helpers.checkIfThereIsEmptyPickedWork(textFieldGroups)) {
        final data = <String, dynamic>{
          'id': uniqueKey,
          'workId': workId,
          'amount': amountFormatted,
          'dateCreated': dateCreated,
        };
        return data;
      }
    }
    return {};
  }
}
