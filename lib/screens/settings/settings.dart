import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/screens/settings/currency_picker/currency_picker.dart';
import 'package:piececalc/screens/settings/language_change/language_change.dart';
import 'package:piececalc/screens/settings/theme_switch/theme_segmented_buttons.dart';
import 'package:piececalc/screens/settings/widgets/show_tutorial_again.dart';
import 'package:piececalc/theme/theme_constants.dart';

import '../../theme/bloc/theme_bloc.dart';
import 'add_work/add_work.dart';
import 'backup/backup.dart';
import 'widgets/app_info_text.dart';
import 'widgets/email_developer_list_tile.dart';
import 'widgets/rate_app_tile.dart';

/// Represents the settings page of the application.
///
/// This widget displays a list of settings options available to the user,
/// including options like changing the theme, adding work, picking currency,
/// creating backups, and changing the language.
class Settings extends StatelessWidget {
  /// Creates an instance of [Settings].
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(settingsPadding),
          children: const [
            ThemeSegmentedButtons(),
            Divider(),
            AddWork(),
            Divider(),
            CurrencyPicker(),
            Divider(),
            Backup(),
            Divider(),
            LanguageChange(),
            Divider(),
            ShowTutorialAgain(),
            Divider(),
            EmailDeveloperListTile(),
            Divider(),
            RateAppTile(),
            Divider(),
            AppInfoText(),
          ],
        );
      },
    );
  }
}
