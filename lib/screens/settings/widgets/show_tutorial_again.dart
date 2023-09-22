import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../data/repositories/settings_repository.dart';
import '../../intro/intro.dart';

/// Defines widget, which responsible for showing tutorial from the start.
class ShowTutorialAgain extends StatelessWidget {
  /// Constructor for [ShowTutorialAgain].
  const ShowTutorialAgain({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(context.l10n.areYouSure),
                actions: [
                  TextButton(
                    child: Text(context.l10n.no),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(context.l10n.yes),
                    onPressed: () {
                      GetIt.I<SettingsRepository>().setBoolValue('first_load', value: false);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute<void>(builder: (context) => const Intro()),
                        (Route<dynamic> route) => false,
                      );
                      //restartApp(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        title: Text(context.l10n.startTutorialAgain),
        leading: const Icon(Icons.school),
        splashColor: Colors.transparent,
      ),
    );
  }
}
