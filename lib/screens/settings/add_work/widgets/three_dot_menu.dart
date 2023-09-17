import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../../data/models/work.dart';
import '../cubit/add_work_cubit.dart';

/// Three dot menu in work tile.
class ThreeDotMenu extends StatelessWidget {
  /// Constructor for [ThreeDotMenu].
  const ThreeDotMenu({required this.workToMakeAnAction, required this.isArchiving, super.key});

  /// Work, to archive or delete.
  final Work workToMakeAnAction;

  /// Bool, shows to archive item or unarchive.
  final bool isArchiving;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      iconSize: 32,
      icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.outline),
      onSelected: (String result) {
        switch (result) {
          case 'Archive':
            // Handle archive action
            context.read<AddWorkCubit>().archiveWork(workToMakeAnAction, isArchiving: isArchiving);
          case 'Delete':
            // Handle delete action
            context.read<AddWorkCubit>().checkDeletionPossibility(workToMakeAnAction);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Archive',
          child: ListTile(
            leading: isArchiving ? const Icon(Icons.archive) : const Icon(Icons.unarchive),
            title: isArchiving
                ? Text(context.l10n.archiveThreeDotMenu)
                : Text(context.l10n.unarchiveThreeDotMenu),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: ListTile(
            leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
            title: Text(
              context.l10n.deleteThreeDotMenu,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
