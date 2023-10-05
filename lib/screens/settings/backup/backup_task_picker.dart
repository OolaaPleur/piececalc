import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/backup/bloc/file_picking_bloc.dart';

/// Screen, shows options, to export data and import data.
class BackupTaskPicker extends StatelessWidget {
  /// Construuctor for [BackupTaskPicker].
  const BackupTaskPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.changeLanguage),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              context.l10n.exportBackupToFile,
              style: TextStyle(fontSize: Theme.of(context).textTheme.labelSmall!.fontSize),
            ),
            onTap: () async {
              await context.read<FilePickingBloc>().createBackupAndShare(
                subject: context.l10n.backupOfMyData,
                text: context.l10n.hereIsMyBackupFromPiececalc,
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              context.l10n.importBackupFromFile,
              style: TextStyle(fontSize: Theme.of(context).textTheme.labelSmall!.fontSize),
            ),
            onTap: () {
              context.read<FilePickingBloc>().pickAndReadFile();
            },
          ),
        ],
      ),
    );
  }
}
