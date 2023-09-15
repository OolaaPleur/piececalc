import '../constants/constants.dart';

extension AppThemeExtension on String {
  AppTheme toAppTheme() {
    switch (this) {
      case 'AppTheme.light':
        return AppTheme.light;
      case 'AppTheme.dark':
        return AppTheme.dark;
      case 'AppTheme.auto':
        return AppTheme.auto;
      default:
        throw ArgumentError('Invalid string value for AppTheme enum');
    }
  }
}
