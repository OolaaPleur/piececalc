// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(count) => "${Intl.plural(count, zero: '0 hours', one: '1 hour', other: '${count} hours')}";

  static m1(count) => "${Intl.plural(count, zero: '0 minutes', one: '1 minute', other: '${count} minutes')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addDoneWork" : MessageLookupByLibrary.simpleMessage("Add done work"),
    "addNewField" : MessageLookupByLibrary.simpleMessage("Add new field"),
    "addNewWork" : MessageLookupByLibrary.simpleMessage("Add new work"),
    "addWorksInSettings" : MessageLookupByLibrary.simpleMessage("Add works in settings"),
    "amount" : MessageLookupByLibrary.simpleMessage("Amount"),
    "appName" : MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
    "april" : MessageLookupByLibrary.simpleMessage("April"),
    "august" : MessageLookupByLibrary.simpleMessage("August"),
    "backup" : MessageLookupByLibrary.simpleMessage("Backup"),
    "changeCurrency" : MessageLookupByLibrary.simpleMessage("Change currency"),
    "changeLanguage" : MessageLookupByLibrary.simpleMessage("Change language"),
    "december" : MessageLookupByLibrary.simpleMessage("December"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("Delete"),
    "earned" : MessageLookupByLibrary.simpleMessage("Earned"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Edit task"),
    "emailToMe" : MessageLookupByLibrary.simpleMessage("Email to me!"),
    "english" : MessageLookupByLibrary.simpleMessage("English"),
    "enterDate" : MessageLookupByLibrary.simpleMessage("Enter Date"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "estonian" : MessageLookupByLibrary.simpleMessage("Estonian"),
    "february" : MessageLookupByLibrary.simpleMessage("February"),
    "friday" : MessageLookupByLibrary.simpleMessage("Friday"),
    "homeBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Timeline"),
    "hourWork" : MessageLookupByLibrary.simpleMessage("Hour work"),
    "hoursOnly" : m0,
    "invalidFormat" : MessageLookupByLibrary.simpleMessage("Invalid Format"),
    "january" : MessageLookupByLibrary.simpleMessage("January"),
    "july" : MessageLookupByLibrary.simpleMessage("July"),
    "june" : MessageLookupByLibrary.simpleMessage("June"),
    "march" : MessageLookupByLibrary.simpleMessage("March"),
    "may" : MessageLookupByLibrary.simpleMessage("May"),
    "minutesOnly" : m1,
    "monday" : MessageLookupByLibrary.simpleMessage("Monday"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noDataForThisMonth" : MessageLookupByLibrary.simpleMessage("No data for this month is found"),
    "noWorkHasBeenAdded" : MessageLookupByLibrary.simpleMessage("No work has been added. To add new work \n1) Go to Settings \n2) Click \'Add new work\'"),
    "noneCurrencyPicked" : MessageLookupByLibrary.simpleMessage("None picked"),
    "november" : MessageLookupByLibrary.simpleMessage("November"),
    "october" : MessageLookupByLibrary.simpleMessage("October"),
    "orPressThisButton" : MessageLookupByLibrary.simpleMessage("Or press this button"),
    "pieceWork" : MessageLookupByLibrary.simpleMessage("Piece work"),
    "piececalc" : MessageLookupByLibrary.simpleMessage("PieceCa(lc)"),
    "pleaseEnterAPrice" : MessageLookupByLibrary.simpleMessage("Please enter a price"),
    "pleaseEnterAValidNumber" : MessageLookupByLibrary.simpleMessage("Please enter a valid number"),
    "pleaseEnterAnAmount" : MessageLookupByLibrary.simpleMessage("Please enter an amount"),
    "pleaseEnterDate" : MessageLookupByLibrary.simpleMessage("Please enter date"),
    "pleaseEnterValidWorkName" : MessageLookupByLibrary.simpleMessage("Please enter valid work name"),
    "pleaseEnterWorkName" : MessageLookupByLibrary.simpleMessage("Please enter work name"),
    "priceForOneHour" : MessageLookupByLibrary.simpleMessage("Price for one hour of work"),
    "priceForOnePiece" : MessageLookupByLibrary.simpleMessage("Price for one piece"),
    "removeField" : MessageLookupByLibrary.simpleMessage("Remove field"),
    "russian" : MessageLookupByLibrary.simpleMessage("Russian"),
    "saturday" : MessageLookupByLibrary.simpleMessage("Saturday"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "selectTime" : MessageLookupByLibrary.simpleMessage("Select Time"),
    "september" : MessageLookupByLibrary.simpleMessage("September"),
    "settingsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsChangeTheme" : MessageLookupByLibrary.simpleMessage("Change Theme"),
    "shareMonthData" : MessageLookupByLibrary.simpleMessage("Share month data"),
    "somethingWentWrong" : MessageLookupByLibrary.simpleMessage("Something went wrong. PLease try again."),
    "statsBottomNavBarTitle" : MessageLookupByLibrary.simpleMessage("Stats"),
    "sunday" : MessageLookupByLibrary.simpleMessage("Sunday"),
    "tapToAddTask" : MessageLookupByLibrary.simpleMessage("Tap to add task"),
    "taskDeletion" : MessageLookupByLibrary.simpleMessage("Task deletion"),
    "tasksNotAddedYet" : MessageLookupByLibrary.simpleMessage("Tasks not added yet, press plus button at the bottom right"),
    "thursday" : MessageLookupByLibrary.simpleMessage("Thursday"),
    "timeIsNotPicked" : MessageLookupByLibrary.simpleMessage("Time is not picked"),
    "timeSpent" : MessageLookupByLibrary.simpleMessage("Time spent"),
    "tuesday" : MessageLookupByLibrary.simpleMessage("Tuesday"),
    "wednesday" : MessageLookupByLibrary.simpleMessage("Wednesday"),
    "workAmount" : MessageLookupByLibrary.simpleMessage("Work amount"),
    "workDeleted" : MessageLookupByLibrary.simpleMessage("Work deleted"),
    "workDeletion" : MessageLookupByLibrary.simpleMessage("Work deletion"),
    "workIsAlreadyUsedInTaskCantDelete" : MessageLookupByLibrary.simpleMessage("Work is already used in task. Cant Delete"),
    "workName" : MessageLookupByLibrary.simpleMessage("Work name"),
    "wouldYouLikeToDeleteThisTask" : MessageLookupByLibrary.simpleMessage("Would you like to delete this task?"),
    "wouldYouLikeToDeleteThisWork" : MessageLookupByLibrary.simpleMessage("Would you like to delete this work?"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
