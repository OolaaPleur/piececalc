import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

/// Extension on BuildContext, to make shorter call.
extension AppLocalizationsX on BuildContext {
  /// Call to AppLocalizations, looks nicer than default.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
