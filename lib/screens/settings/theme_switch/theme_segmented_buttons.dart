import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/constants/constants.dart';
import 'package:piececalc/l10n/l10n.dart';
import '../../../theme/bloc/theme_bloc.dart';
import 'theme_switch_helpers.dart';

/// Widget dropdown in Settings, changes theme of an app.
class ThemeSegmentedButtons extends StatefulWidget {
  /// Constructor for [ThemeSegmentedButtons].
  const ThemeSegmentedButtons({
    super.key,
  });

  @override
  State<ThemeSegmentedButtons> createState() => _ThemeSegmentedButtonsState();
}

class _ThemeSegmentedButtonsState extends State<ThemeSegmentedButtons> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        var themeState = convertStateInEnum(state);
        return SegmentedButton<AppTheme>(
          key: const Key('theme_switcher'),
          segments: <ButtonSegment<AppTheme>>[
            ButtonSegment<AppTheme>(
              value: AppTheme.light,
              label: Text(context.l10n.light),
              icon: const Icon(Icons.light_mode),
            ),
            ButtonSegment<AppTheme>(
              value: AppTheme.auto,
              label: Text(context.l10n.auto),
              icon: const Icon(Icons.auto_mode),
            ),
            ButtonSegment<AppTheme>(
              value: AppTheme.dark,
              label: Text(context.l10n.dark),
              icon: const Icon(Icons.dark_mode),
            ),
          ],
          selected: <AppTheme>{themeState},
          onSelectionChanged: (Set<AppTheme> newSelection) {
            setState(() {
              themeState = newSelection.first;
            });
            context.read<ThemeBloc>().add(ChangeThemeEvent(appTheme: newSelection.first));
          },
        );
      },
    );
  }
}
