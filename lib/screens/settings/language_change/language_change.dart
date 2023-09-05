import 'package:flutter/material.dart';
import 'package:piececalc/screens/settings/language_change/language_change_page.dart';

/// A widget that provides an option to change the language.
///
/// When tapped, it navigates the user to the [LanguageChangePage] where
/// they can select a different language.
class LanguageChange extends StatelessWidget {

  /// Creates a [LanguageChange] widget.
  ///
  /// The [key] parameter is optional and is forwarded to the parent class.
  const LanguageChange({super.key});

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
        title: const Text('change lang'),
        subtitle: const Text('en'),
        leading: const Icon(Icons.language),
        trailing: const Icon(Icons.keyboard_arrow_right),
        splashColor: Colors.transparent,
      ),
    );
  }
}
