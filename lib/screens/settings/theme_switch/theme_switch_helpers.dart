import '../../../constants/constants.dart';
import '../../../theme/bloc/theme_bloc.dart';

AppTheme convertStateInEnum (ThemeState state) {
  if (state is LightThemeState) {
    return AppTheme.light;
  }
  if (state is DarkThemeState) {
    return AppTheme.dark;
  }
  return AppTheme.auto;
}
ThemeState convertEnumInState (AppTheme appTheme) {
  if (appTheme == AppTheme.light) {
    return LightThemeState();
  }
  if (appTheme == AppTheme.dark) {
    return DarkThemeState();
  }
  return AutoThemeState();
}
