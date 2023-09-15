import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:piececalc/constants/constants.dart';
import 'package:piececalc/theme/extensions.dart';

import '../../data/repositories/settings_repository.dart';
import '../theme.dart';

part 'theme_event.dart';

part 'theme_state.dart';

/// Bloc class, main job is defining a theme for an app.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  /// Constructor for ThemeBloc.
  ThemeBloc()
      : _settingsRepository = GetIt.I<SettingsRepository>(),
        super(LightThemeState()) {
    on<LoadThemeEvent>(_onLoadThemeEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
    on<ToggleDownloadedThemeEvent>(_onToggleDownloadedThemeEvent);
  }

  final SettingsRepository _settingsRepository;

  /// Checks if dark mode is enabled right now.
  bool get isDarkMode {
    if (state.themeData.brightness == Brightness.light) {
      return false;
    }
    return true;
  }

  ThemeState get currentTheme {
    return state;
  }

  /// Load theme at the start of an app.
  Future<void> _onLoadThemeEvent(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final theme = await _settingsRepository.getStringValue('theme');
    final themeEnum = theme.toAppTheme();
    add(ToggleDownloadedThemeEvent(theme: themeEnum));
  }

  /// Toggle another theme, button located in settings.
  Future<void> _onChangeThemeEvent(
    ChangeThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (event.themeState is DarkThemeState) {
      emit(DarkThemeState());
      await _settingsRepository.setStringValue('theme', 'AppTheme.dark');
    } else if (event.themeState is LightThemeState) {
      emit(LightThemeState());
      await _settingsRepository.setStringValue('theme', 'AppTheme.light');
    } else {
      emit(AutoThemeState());
      await _settingsRepository.setStringValue('theme', 'AppTheme.auto');
    }
  }

  /// Used to set theme in two cases 1) when downloaded user settings
  /// 2) when theme set by user in [LoadThemeEvent].
  Future<void> _onToggleDownloadedThemeEvent(
    ToggleDownloadedThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (event.theme == AppTheme.dark) {
      emit(DarkThemeState());
    } else if (event.theme == AppTheme.light) {
      emit(LightThemeState());
    } else {
      emit(AutoThemeState());
    }
  }
}
