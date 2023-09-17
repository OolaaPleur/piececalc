import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import 'add_work_page.dart';
import 'cubit/add_work_cubit.dart';

/// Widget dropdown in Settings, changes city.
class AddWork extends StatelessWidget {
  /// Constructor for [AddWork].
  const AddWork({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Card(
          child: ListTile(
            onTap: () {
              final cubit = context.read<AddWorkCubit>()..loadWorks();
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => BlocProvider.value(
                    value: cubit,
                    child: const AddWorkPage(),
                  ),
                ),
              );
            },
            title: Text(context.l10n.addNewWork),
            //subtitle: Text(AppLocalizations.of(context)!.changeCity),
            leading: const Icon(Icons.warehouse),
            trailing: const Icon(Icons.keyboard_arrow_right),
            splashColor: Colors.transparent,
          ),
        );
      },
    );
  }
}
