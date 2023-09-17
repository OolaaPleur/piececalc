import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/constants.dart';
import '../../../data/models/work.dart';
import 'cubit/add_work_cubit.dart';

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
      'isArchived': editedObject == null ? 0 : editedObject.isArchived
    ,};
  }
  /// Function, shows alert dialog when tried to delete work.
  void showAlertDialog(BuildContext context, Work work) {
    // set up the buttons
    final Widget cancelButton = TextButton(
      child: Text(context.l10n.yes),
      onPressed: () {
        context.read<AddWorkCubit>().deleteWork(work);
        Navigator.pop(context);
      },
    );
    final Widget continueButton = TextButton(
      child: Text(context.l10n.no),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    final alert = AlertDialog(
      title: Text(context.l10n.workDeletion),
      content: Text(context.l10n.wouldYouLikeToDeleteThisWork),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
