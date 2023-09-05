import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('change lang'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Text(
              'en',
              textScaleFactor: 2,
            ),
            title: const Text(
              'English',
              textScaleFactor: 1.2,
            ),
            onTap: () {
              context.read<LanguageCubit>().changeLanguage(context.read<LanguageCubit>().state);
              Navigator.pop(context);
            },
            trailing: const Icon(Icons.check, color: Colors.green),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
