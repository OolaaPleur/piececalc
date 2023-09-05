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
      desc: 'App name',
      args: [],
    );
  }

  /// `Profile`
  String get profileBottomNavBarTitle {
    return Intl.message(
      'Profile',
      name: 'profileBottomNavBarTitle',
      desc: 'Title for the profile section',
      args: [],
    );
  }

  /// `Timeline`
  String get homeBottomNavBarTitle {
    return Intl.message(
      'Timeline',
      name: 'homeBottomNavBarTitle',
      desc: 'Title for the list section',
      args: [],
    );
  }

  /// `Settings`
  String get settingsBottomNavBarTitle {
    return Intl.message(
      'Settings',
      name: 'settingsBottomNavBarTitle',
      desc: 'Title for the settings section',
      args: [],
    );
  }

  /// `Add done work`
  String get addDoneWork {
    return Intl.message(
      'Add done work',
      name: 'addDoneWork',
      desc: 'Text shown in add done work screen in appBar',
      args: [],
    );
  }

  /// `Work amount`
  String get workAmount {
    return Intl.message(
      'Work amount',
      name: 'workAmount',
      desc: 'Text shown in add done work screen in appBar',
      args: [],
    );
  }

  /// `Change Theme`
  String get settingsChangeTheme {
    return Intl.message(
      'Change Theme',
      name: 'settingsChangeTheme',
      desc: 'Text shown on change theme toggle',
      args: [],
    );
  }

  /// `Add new work`
  String get addNewWork {
    return Intl.message(
      'Add new work',
      name: 'addNewWork',
      desc: 'Text shown on add new work tile',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message(
      'Backup',
      name: 'backup',
      desc: 'Text shown on add new work tile',
      args: [],
    );
  }

  /// `Work name`
  String get workName {
    return Intl.message(
      'Work name',
      name: 'workName',
      desc: 'Text shown on page, where new work is added',
      args: [],
    );
  }

  /// `Piece work`
  String get pieceWork {
    return Intl.message(
      'Piece work',
      name: 'pieceWork',
      desc: 'Text shown on page, where new work is added',
      args: [],
    );
  }

  /// `Hour work`
  String get hourWork {
    return Intl.message(
      'Hour work',
      name: 'hourWork',
      desc: 'Text shown on page, where new work is added',
      args: [],
    );
  }

  /// `Price for one piece`
  String get priceForOnePiece {
    return Intl.message(
      'Price for one piece',
      name: 'priceForOnePiece',
      desc: 'Text shown on page, where new work is added',
      args: [],
    );
  }

  /// `Price for one hour of work`
  String get priceForOneHour {
    return Intl.message(
      'Price for one hour of work',
      name: 'priceForOneHour',
      desc: 'Text shown on page, where new work is added',
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
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