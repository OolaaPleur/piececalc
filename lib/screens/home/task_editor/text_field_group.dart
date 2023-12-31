import 'package:flutter/material.dart';

import '../../../data/models/work.dart';

/// Represents a group of text fields and their associated properties.
///
/// This class provides a mechanism to bundle multiple groups of text fields
/// with their relevant controllers, focus nodes, keys, and matched work data.
class TextFieldGroup {
  /// Controller for handling the text input of the amount field.
  TextEditingController amountController = TextEditingController();

  /// Controller for handling the input and suggestions in the type-ahead field.
  TextEditingController typeAheadController = TextEditingController();

  /// Shows, is text field showed to user or not.
  bool commentTextFieldEnabled = false;

  /// Controller for handling the comment input in text field.
  TextEditingController commentController = TextEditingController();

  /// Focus node to manage focus behavior for the work name field.
  FocusNode typeAheadFocusNode = FocusNode();

  /// Focus node to manage focus behavior for the amount field.
  FocusNode amountFocusNode = FocusNode();

  /// Focus node to manage focus behavior for the comment field.
  FocusNode commentFocusNode = FocusNode();

  /// Global key to uniquely identify the widget tree for this text field group.
  GlobalKey<FormFieldState<String>> globalKey = GlobalKey<FormFieldState<String>>();

  /// [TimeOfDay] object, stores user inputted time.
  TimeOfDay time = const TimeOfDay(hour: 0, minute: 0);

  /// The associated [Work] data that matches with the input from the type-ahead work-related
  /// text field.
  Work? matchedWork;
}
