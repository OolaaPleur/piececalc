import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'utils/database/populate_test_data.dart';
import 'utils/service_locator.dart';

/// Observer for BLoC logic of the app.
class AppBlocObserver extends BlocObserver {
  /// Constructor for BLoC observer.
  const AppBlocObserver();

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('onClose(${bloc.runtimeType})');
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Starts an observer and an app.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  /// If app opened in web - change database factory.
  if (kIsWeb) {
    // Change default factory on the web
    databaseFactory = databaseFactoryFfiWeb;
  }
  await setUpServicesLocator();
  /// Populate app with data in debug mode.
  if (kDebugMode) {
    await PopulateTestData().populateTestData();
  }

  /// Logger initialisation.
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log('${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}');
  });

  /// Log errors.
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) => '';
  }
  /// Start BLoC observer.
  Bloc.observer = const AppBlocObserver();

  if (defaultTargetPlatform  == TargetPlatform.android) {
    // Add cross-flavor configuration here
    await Firebase.initializeApp();
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
  runApp(await builder());
}
