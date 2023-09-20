// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PieceCa(lc)`
  String get appName {
    return Intl.message(
      'PieceCa(lc)',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get statsBottomNavBarTitle {
    return Intl.message(
      'Stats',
      name: 'statsBottomNavBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Timeline`
  String get homeBottomNavBarTitle {
    return Intl.message(
      'Timeline',
      name: 'homeBottomNavBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsBottomNavBarTitle {
    return Intl.message(
      'Settings',
      name: 'settingsBottomNavBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add done work`
  String get addDoneWork {
    return Intl.message(
      'Add done work',
      name: 'addDoneWork',
      desc: '',
      args: [],
    );
  }

  /// `Work amount`
  String get workAmount {
    return Intl.message(
      'Work amount',
      name: 'workAmount',
      desc: '',
      args: [],
    );
  }

  /// `Change Theme`
  String get settingsChangeTheme {
    return Intl.message(
      'Change Theme',
      name: 'settingsChangeTheme',
      desc: '',
      args: [],
    );
  }

  /// `Add new work`
  String get addNewWork {
    return Intl.message(
      'Add new work',
      name: 'addNewWork',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message(
      'Backup',
      name: 'backup',
      desc: '',
      args: [],
    );
  }

  /// `Work name`
  String get workName {
    return Intl.message(
      'Work name',
      name: 'workName',
      desc: '',
      args: [],
    );
  }

  /// `Piece work`
  String get pieceWork {
    return Intl.message(
      'Piece work',
      name: 'pieceWork',
      desc: '',
      args: [],
    );
  }

  /// `Hour work`
  String get hourWork {
    return Intl.message(
      'Hour work',
      name: 'hourWork',
      desc: '',
      args: [],
    );
  }

  /// `Price for one piece`
  String get priceForOnePiece {
    return Intl.message(
      'Price for one piece',
      name: 'priceForOnePiece',
      desc: '',
      args: [],
    );
  }

  /// `Price for one hour of work`
  String get priceForOneHour {
    return Intl.message(
      'Price for one hour of work',
      name: 'priceForOneHour',
      desc: '',
      args: [],
    );
  }

  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get february {
    return Intl.message(
      'February',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get june {
    return Intl.message(
      'June',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. PLease try again.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong. PLease try again.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Edit task`
  String get editTask {
    return Intl.message(
      'Edit task',
      name: 'editTask',
      desc: '',
      args: [],
    );
  }

  /// `Please enter date`
  String get pleaseEnterDate {
    return Intl.message(
      'Please enter date',
      name: 'pleaseEnterDate',
      desc: '',
      args: [],
    );
  }

  /// `Enter Date`
  String get enterDate {
    return Intl.message(
      'Enter Date',
      name: 'enterDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter work name`
  String get pleaseEnterWorkName {
    return Intl.message(
      'Please enter work name',
      name: 'pleaseEnterWorkName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid work name`
  String get pleaseEnterValidWorkName {
    return Intl.message(
      'Please enter valid work name',
      name: 'pleaseEnterValidWorkName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an amount`
  String get pleaseEnterAnAmount {
    return Intl.message(
      'Please enter an amount',
      name: 'pleaseEnterAnAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get pleaseEnterAValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'pleaseEnterAValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteTask {
    return Intl.message(
      'Delete',
      name: 'deleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Remove field`
  String get removeField {
    return Intl.message(
      'Remove field',
      name: 'removeField',
      desc: '',
      args: [],
    );
  }

  /// `No work has been added. To add new work \n1) Go to Settings \n2) Click 'Add new work'`
  String get noWorkHasBeenAdded {
    return Intl.message(
      'No work has been added. To add new work \n1) Go to Settings \n2) Click \'Add new work\'',
      name: 'noWorkHasBeenAdded',
      desc: '',
      args: [],
    );
  }

  /// `Or press this button`
  String get orPressThisButton {
    return Intl.message(
      'Or press this button',
      name: 'orPressThisButton',
      desc: '',
      args: [],
    );
  }

  /// `Tasks not added yet, press plus button at the bottom right`
  String get tasksNotAddedYet {
    return Intl.message(
      'Tasks not added yet, press plus button at the bottom right',
      name: 'tasksNotAddedYet',
      desc: '',
      args: [],
    );
  }

  /// `Earned`
  String get earned {
    return Intl.message(
      'Earned',
      name: 'earned',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `None picked`
  String get noneCurrencyPicked {
    return Intl.message(
      'None picked',
      name: 'noneCurrencyPicked',
      desc: '',
      args: [],
    );
  }

  /// `Change currency`
  String get changeCurrency {
    return Intl.message(
      'Change currency',
      name: 'changeCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Work deleted`
  String get workDeleted {
    return Intl.message(
      'Work deleted',
      name: 'workDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Work is already used in task. Can't Delete`
  String get workIsAlreadyUsedInTaskCantDelete {
    return Intl.message(
      'Work is already used in task. Can\'t Delete',
      name: 'workIsAlreadyUsedInTaskCantDelete',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a price`
  String get pleaseEnterAPrice {
    return Intl.message(
      'Please enter a price',
      name: 'pleaseEnterAPrice',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Add works in settings`
  String get addWorksInSettings {
    return Intl.message(
      'Add works in settings',
      name: 'addWorksInSettings',
      desc: '',
      args: [],
    );
  }

  /// `Tap to add task`
  String get tapToAddTask {
    return Intl.message(
      'Tap to add task',
      name: 'tapToAddTask',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get russian {
    return Intl.message(
      'Russian',
      name: 'russian',
      desc: '',
      args: [],
    );
  }

  /// `Estonian`
  String get estonian {
    return Intl.message(
      'Estonian',
      name: 'estonian',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get changeLanguage {
    return Intl.message(
      'Change language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `No data for this month is found`
  String get noDataForThisMonth {
    return Intl.message(
      'No data for this month is found',
      name: 'noDataForThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Share month data`
  String get shareMonthData {
    return Intl.message(
      'Share month data',
      name: 'shareMonthData',
      desc: '',
      args: [],
    );
  }

  /// `Time spent`
  String get timeSpent {
    return Intl.message(
      'Time spent',
      name: 'timeSpent',
      desc: '',
      args: [],
    );
  }

  /// `Time is not picked`
  String get timeIsNotPicked {
    return Intl.message(
      'Time is not picked',
      name: 'timeIsNotPicked',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Task deletion`
  String get taskDeletion {
    return Intl.message(
      'Task deletion',
      name: 'taskDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to delete this task?`
  String get wouldYouLikeToDeleteThisTask {
    return Intl.message(
      'Would you like to delete this task?',
      name: 'wouldYouLikeToDeleteThisTask',
      desc: '',
      args: [],
    );
  }

  /// `Work deletion`
  String get workDeletion {
    return Intl.message(
      'Work deletion',
      name: 'workDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to delete this work?`
  String get wouldYouLikeToDeleteThisWork {
    return Intl.message(
      'Would you like to delete this work?',
      name: 'wouldYouLikeToDeleteThisWork',
      desc: '',
      args: [],
    );
  }

  /// `Have questions? Email to me!`
  String get emailToMe {
    return Intl.message(
      'Have questions? Email to me!',
      name: 'emailToMe',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Format`
  String get invalidFormat {
    return Intl.message(
      'Invalid Format',
      name: 'invalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `PieceCa(lc)`
  String get piececalc {
    return Intl.message(
      'PieceCa(lc)',
      name: 'piececalc',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Add new field`
  String get addNewField {
    return Intl.message(
      'Add new field',
      name: 'addNewField',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{0 hours} =1{1 hour} other{{count} hours}}`
  String hoursOnly(num count) {
    return Intl.plural(
      count,
      zero: '0 hours',
      one: '1 hour',
      other: '$count hours',
      name: 'hoursOnly',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0{0 minutes} =1{1 minute} other{{count} minutes}}`
  String minutesOnly(num count) {
    return Intl.plural(
      count,
      zero: '0 minutes',
      one: '1 minute',
      other: '$count minutes',
      name: 'minutesOnly',
      desc: '',
      args: [count],
    );
  }

  /// `Could not launch`
  String get couldNotLaunch {
    return Intl.message(
      'Could not launch',
      name: 'couldNotLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Rate us on Google Play!`
  String get rateUsOnGooglePlay {
    return Intl.message(
      'Rate us on Google Play!',
      name: 'rateUsOnGooglePlay',
      desc: '',
      args: [],
    );
  }

  /// `Your feedback motivates me to make the app even better!`
  String get yourFeedbackMotivatesMeToMakeTheAppEvenBetter {
    return Intl.message(
      'Your feedback motivates me to make the app even better!',
      name: 'yourFeedbackMotivatesMeToMakeTheAppEvenBetter',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to PieceCa(lc) 📊`
  String get introFirstScreenHeader {
    return Intl.message(
      'Welcome to PieceCa(lc) 📊',
      name: 'introFirstScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `Your essential companion for tracking and calculating work outcomes. Say goodbye to the tedious task of calculating earnings — save time with PieceCa(lc).`
  String get introFirstScreenBody {
    return Intl.message(
      'Your essential companion for tracking and calculating work outcomes. Say goodbye to the tedious task of calculating earnings — save time with PieceCa(lc).',
      name: 'introFirstScreenBody',
      desc: '',
      args: [],
    );
  }

  /// `Instant Work Calculation 💹`
  String get introSecondScreenHeader {
    return Intl.message(
      'Instant Work Calculation 💹',
      name: 'introSecondScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `Calculate the amount of work you've done with a tap and get a clear, organized overview instantly.`
  String get introSecondScreenBody {
    return Intl.message(
      'Calculate the amount of work you\'ve done with a tap and get a clear, organized overview instantly.',
      name: 'introSecondScreenBody',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Organization 📅`
  String get introSecondAndHalfScreenHeader {
    return Intl.message(
      'Monthly Organization 📅',
      name: 'introSecondAndHalfScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `With PieceCa(lc), your tasks are automatically sorted by month. Making it easier than ever to review and track your progress.`
  String get introSecondAndHalfScreenBody {
    return Intl.message(
      'With PieceCa(lc), your tasks are automatically sorted by month. Making it easier than ever to review and track your progress.',
      name: 'introSecondAndHalfScreenBody',
      desc: '',
      args: [],
    );
  }

  /// `Secure Backup 🛡️`
  String get introThirdScreenHeader {
    return Intl.message(
      'Secure Backup 🛡️',
      name: 'introThirdScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `Never fear data loss. Easily create backups for all your data or for specific tasks from any month.`
  String get introThirdScreenBody {
    return Intl.message(
      'Never fear data loss. Easily create backups for all your data or for specific tasks from any month.',
      name: 'introThirdScreenBody',
      desc: '',
      args: [],
    );
  }

  /// `Intuitive Design 🎨`
  String get introFourthScreenHeader {
    return Intl.message(
      'Intuitive Design 🎨',
      name: 'introFourthScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `A user-friendly interface designed with you in mind. Navigate with ease and get more done.`
  String get introFourthScreenBody {
    return Intl.message(
      'A user-friendly interface designed with you in mind. Navigate with ease and get more done.',
      name: 'introFourthScreenBody',
      desc: '',
      args: [],
    );
  }

  /// `Light & Dark Mode 🌓`
  String get introFifthScreenHeader {
    return Intl.message(
      'Light & Dark Mode 🌓',
      name: 'introFifthScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `Choose your vibe. Toggle between light and dark themes to match your mood or your surroundings.`
  String get introFifthScreenBody {
    return Intl.message(
      'Choose your vibe. Toggle between light and dark themes to match your mood or your surroundings.',
      name: 'introFifthScreenBody',
      desc: '',
      args: [],
    );
  }

  /// `Ready to Begin? 🚀`
  String get introSixthScreenHeader {
    return Intl.message(
      'Ready to Begin? 🚀',
      name: 'introSixthScreenHeader',
      desc: '',
      args: [],
    );
  }

  /// `Dive into PieceCa(lc) and start making your work calculation more organized and efficient today!`
  String get introSixthScreenBody {
    return Intl.message(
      'Dive into PieceCa(lc) and start making your work calculation more organized and efficient today!',
      name: 'introSixthScreenBody',
      desc: '',
      args: [],
    );
  }

  /// `Start tutorial again`
  String get startTutorialAgain {
    return Intl.message(
      'Start tutorial again',
      name: 'startTutorialAgain',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Select color`
  String get selectColor {
    return Intl.message(
      'Select color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Select color shade`
  String get selectColorShade {
    return Intl.message(
      'Select color shade',
      name: 'selectColorShade',
      desc: '',
      args: [],
    );
  }

  /// `Selected color and its shades`
  String get selectedColorAndItsShades {
    return Intl.message(
      'Selected color and its shades',
      name: 'selectedColorAndItsShades',
      desc: '',
      args: [],
    );
  }

  /// `Edit work`
  String get editWork {
    return Intl.message(
      'Edit work',
      name: 'editWork',
      desc: '',
      args: [],
    );
  }

  /// `Comment for task`
  String get commentForTask {
    return Intl.message(
      'Comment for task',
      name: 'commentForTask',
      desc: '',
      args: [],
    );
  }

  /// `Works hasn't been archived yet. To archive work - tap three-dot menu on work list tile and tap 'Archive'`
  String get worksHasntBeenArchivedYetToArchiveWorkTapThreedot {
    return Intl.message(
      'Works hasn\'t been archived yet. To archive work - tap three-dot menu on work list tile and tap \'Archive\'',
      name: 'worksHasntBeenArchivedYetToArchiveWorkTapThreedot',
      desc: '',
      args: [],
    );
  }

  /// `Archived works aren't showing in add task work suggestions`
  String get archivedWorksArentShowingInAddTaskWorkSuggestions {
    return Intl.message(
      'Archived works aren\'t showing in add task work suggestions',
      name: 'archivedWorksArentShowingInAddTaskWorkSuggestions',
      desc: '',
      args: [],
    );
  }

  /// `Archive:`
  String get archiveHeader {
    return Intl.message(
      'Archive:',
      name: 'archiveHeader',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archiveThreeDotMenu {
    return Intl.message(
      'Archive',
      name: 'archiveThreeDotMenu',
      desc: '',
      args: [],
    );
  }

  /// `Unarchive`
  String get unarchiveThreeDotMenu {
    return Intl.message(
      'Unarchive',
      name: 'unarchiveThreeDotMenu',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteThreeDotMenu {
    return Intl.message(
      'Delete',
      name: 'deleteThreeDotMenu',
      desc: '',
      args: [],
    );
  }

  /// `Backup of my data`
  String get backupOfMyData {
    return Intl.message(
      'Backup of my data',
      name: 'backupOfMyData',
      desc: '',
      args: [],
    );
  }

  /// `Here is my backup from PieceCalc.`
  String get hereIsMyBackupFromPiececalc {
    return Intl.message(
      'Here is my backup from PieceCalc.',
      name: 'hereIsMyBackupFromPiececalc',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get auto {
    return Intl.message(
      'Auto',
      name: 'auto',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `🔍 Chart Guide: Days on the x-axis. Money earned on the y-axis.`
  String get chartGuideDaysOnTheXaxisMoneyEarnedOnThe {
    return Intl.message(
      '🔍 Chart Guide: Days on the x-axis. Money earned on the y-axis.',
      name: 'chartGuideDaysOnTheXaxisMoneyEarnedOnThe',
      desc: '',
      args: [],
    );
  }

  /// `Total earned`
  String get totalEarned {
    return Intl.message(
      'Total earned',
      name: 'totalEarned',
      desc: '',
      args: [],
    );
  }

  /// `Here is my month tasks backup for {date} from PieceCalc.`
  String shareSubjectText(Object date) {
    return Intl.message(
      'Here is my month tasks backup for $date from PieceCalc.',
      name: 'shareSubjectText',
      desc: '',
      args: [date],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'et'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}