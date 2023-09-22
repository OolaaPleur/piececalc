import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/constants/constants.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/language_change/language_cubit.dart';

/// A page that provides a user interface to change the application's language.
///
/// This page allows users to select a preferred language for the application
/// from the available options. After a language is selected, it is expected
/// that the application will reflect the change.
class LanguageChangePage extends StatelessWidget {
  /// Creates a [LanguageChangePage] widget.
  ///
  /// The [key] parameter is optional and is forwarded to the parent class.
  const LanguageChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.read<LanguageCubit>().state.languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.changeLanguage),
      ),
      body: ListView(
        children: languageToLocalKey.keys.map((language) {
          return Column(
            children: [
              ListTile(
                leading: Text(
                  language.values.first,
                  style: TextStyle(fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
                ),
                title: Text(
                  languageToLocalKey[language]!(context.l10n),
                  style: TextStyle(fontSize: Theme.of(context).textTheme.labelSmall!.fontSize),
                ),
                onTap: () {
                  context.read<LanguageCubit>().changeLanguage(Locale(language.keys.first));
                  Navigator.pop(context);
                },
                trailing: language.keys.first == currentLanguage
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
              ),
              const Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
