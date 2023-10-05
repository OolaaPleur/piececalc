import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';

import 'backup_task_picker.dart';

/// A [StatelessWidget] that provides a UI for creating and sharing backups.
///
/// When tapped, it triggers the backup creation process and then allows
/// the user to share the backup file.
class Backup extends StatelessWidget {
  /// Creates a [Backup] widget.
  ///
  /// The [Key] argument is optional and can be used to differentiate
  /// between multiple [Backup] widgets in the widget tree.
  const Backup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const BackupTaskPicker(),
            ),
          );

        },
        title: Text(context.l10n.backup),
        leading: const Icon(Icons.storage),
        trailing: const Icon(Icons.keyboard_arrow_right),
        splashColor: Colors.transparent,
      ),
    );
  }
}
