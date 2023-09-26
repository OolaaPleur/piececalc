import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/language_change/language_change_page.dart';

import 'language_cubit.dart';

/// A widget that provides an option to change the language.
///
/// When tapped, it navigates the user to the [LanguageChangePage] where
/// they can select a different language.
class LanguageChange extends StatelessWidget {

  /// Creates a [LanguageChange] widget.
  ///
  /// The [key] parameter is optional and is forwarded to the parent class.
  const LanguageChange({super.key});

  /// Changes title on ListTile.
  Text changeTitle(BuildContext context) {
    if (context.read<LanguageCubit>().state.languageCode == 'en') {
      return Text(AppLocalizations.of(context)!.english);
    } else if (context.read<LanguageCubit>().state.languageCode == 'ru') {
      return Text(AppLocalizations.of(context)!.russian);
    } else if (context.read<LanguageCubit>().state.languageCode == 'et') {
      return Text(AppLocalizations.of(context)!.estonian);
    } else {
      return Text(AppLocalizations.of(context)!.english);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const LanguageChangePage(),
            ),
          );
        },
        title: Text(context.l10n.changeLanguage),
        subtitle: changeTitle(context),
        leading: const Icon(Icons.language),
        trailing: const Icon(Icons.keyboard_arrow_right),
        splashColor: Colors.transparent,
      ),
    );
  }
}
