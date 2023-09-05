import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension on BuildContext, to make shorter call.
extension AppLocalizationsX on BuildContext {
  /// Call to AppLocalizations, looks nicer than default.
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
