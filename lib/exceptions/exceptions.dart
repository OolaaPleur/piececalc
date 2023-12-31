/// Class for exception, that could be in app.
/// IMPORTANT: NAMING CONVENTION: class name should be part of l10n string
/// key, e.g. 'snackbarCantFetchBoltScootersData' exception is
/// [SomeErrorHappened].
class AppException implements Exception {
  /// Constructor for [AppException].
  const AppException();
}
/// Define a constant for default [AppException] object.
const noException = AppException();

/// Exception that is thrown when some error happened.
class SomeErrorHappened implements AppException {
  /// Constructor for [SomeErrorHappened].
  const SomeErrorHappened();
}

/// Exception that is thrown when Play Market page of app can't be opened.
class CouldNotLaunch implements AppException {
  /// Constructor for [CouldNotLaunch].
  const CouldNotLaunch();
}
