import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../constants/constants.dart';
import '../../data/models/composite_task_info.dart';
import '../../data/models/work.dart';
import '../home/task_editor/text_field_group.dart';

/// Helper functions for tasks page.
class TasksHelper {

  /// Converts data to map, then it will be added to database.
  static Map<String, dynamic> convertDataFromTextFieldsIntoMap({
    required String amount,
    required String dateCreated,
    required String workId,
    required Work matchedWork,
    required TimeOfDay time,
    required BuildContext context,
    required List<TextFieldGroup> textFieldGroups,
    required String comment,
    CompositeTaskInfo? editedObject,
  }) {
    String amountFormatted;
    if (matchedWork.paymentType == PaymentType.piecewisePayment.toString().split('.').last) {
      amountFormatted = amount.replaceAll(',', '.');
    } else if (matchedWork.paymentType == PaymentType.hourlyPayment.toString().split('.').last) {
      amountFormatted = formatTimeOfDay(time);
    } else {
      amountFormatted = amount;
    }
    if (editedObject != null) {
      final data = <String, dynamic>{
        'id': editedObject.completedTask.id,
        'workId': workId,
        'amount': amountFormatted,
        'dateCreated': dateCreated,
        'comment': comment,
      };
      return data;
    } else {
      const uuid = Uuid();
      final uniqueKey = uuid.v1();
      if (!checkIfThereIsEmptyPickedWork(textFieldGroups)) {
        final data = <String, dynamic>{
          'id': uniqueKey,
          'workId': workId,
          'amount': amountFormatted,
          'dateCreated': dateCreated,
          'comment': comment,
        };
        return data;
      }
    }
    return {};
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

  /// Function, made to ensure same calculation even if device have am/pm
  /// as localized time.
  static String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.Hm().format(dt); // Uses 24-hour format without AM/PM
  }
}
