import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/constants.dart';
import '../../../data/models/work.dart';

/// Helpers functions for AddWork-related widgets.
class AddWorkHelpers {
  /// Converts the provided widget data into a map representation.
  ///
  /// If [editedObject] is not null, it indicates the work data is being updated, and the map will
  /// contain the same `id` as the [editedObject]. Otherwise, a new unique `id` is generated.
  ///
  /// The resulting map will contain the `workName`, `workType`, and `price` fields.
  ///
  /// - Parameters:
  ///   - [editedObject]: The work object being edited, if any.
  ///   - [workNameController]: The controller containing the work's name.
  ///   - [workType]: The type of payment for the work.
  ///   - [priceController]: The controller containing the work's price.
  static Map<String, dynamic> convertTextFieldsDataToWork({
    required Work? editedObject,
    required String workName,
    required PaymentType workType,
    required TextEditingController priceController,
    required Color workColor,
  }) {
    final priceWithDot = priceController.text.trim().replaceAll(',', '.');
    final uniqueKey = const Uuid().v1();
    return {
      'id': editedObject != null ? editedObject.id : uniqueKey,
      'workName': workName,
      'workType': workType == PaymentType.piecewisePayment ? 'piecewisePayment' : 'hourlyPayment',
      'price': priceWithDot,
      'workColor': workColor.value.toString(),
    };
  }
}
