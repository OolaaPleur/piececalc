part of 'theme_bloc.dart';

/// [ThemeBloc] events.
abstract class ThemeEvent {}

/// Toggle another theme, button located in settings.
class ChangeThemeEvent extends ThemeEvent {
  ChangeThemeEvent({required this.themeState});

  final ThemeState themeState;
}

/// Load theme at the start of an app.
class LoadThemeEvent extends ThemeEvent {}

/// Toggle theme from downloaded data.
class ToggleDownloadedThemeEvent extends ThemeEvent {
  /// Constructor for [ToggleDownloadedThemeEvent].
  ToggleDownloadedThemeEvent({required this.theme});

  /// AppTheme enum property, specifies which theme to toggle, dark, light or auto.
  final AppTheme theme;
}
