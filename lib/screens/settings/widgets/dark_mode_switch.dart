import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import '../../../theme/bloc/theme_bloc.dart';

/// Widget dropdown in Settings, changes theme of an app.
class DarkModeSwitch extends StatelessWidget {
  /// Constructor for [DarkModeSwitch].
  const DarkModeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Card(
          child: SwitchListTile(
            key: const Key('dark_mode_switcher'),
            title: Row(
              children: [
                const Icon(Icons.brightness_6),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  context.l10n.settingsChangeTheme,
                ),
              ],
            ),
            value: context
                .read<ThemeBloc>()
                .isDarkModeEnabled,
            onChanged: (bool value) {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
        );
      },
    );
  }
}
