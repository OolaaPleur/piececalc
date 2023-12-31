import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../theme/theme_constants.dart';
import '../../settings/add_work/add_work_page.dart';
import '../../settings/add_work/cubit/add_work_cubit.dart';

/// Widget, defines text and button when no work has been added to the app.
class NoWorkHasBeenAddedWidget extends StatelessWidget {
  /// Constructor for [NoWorkHasBeenAddedWidget].
  const NoWorkHasBeenAddedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(emptyTasksPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.noWorkHasBeenAdded,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) {
                      context.read<AddWorkCubit>();
                      return const AddWorkPage();
                    },
                  ),
                );
              },
              child: Text(context.l10n.orPressThisButton),
            ),
          ],
        ),
      ),
    );
  }
}
