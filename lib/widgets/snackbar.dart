import 'package:flutter/material.dart';
import 'package:piececalc/l10n/l10n.dart';

/// Class, defines how snackbar look like in app.
class AppSnackBar {
  /// Constructor for [AppSnackBar].
  AppSnackBar(
    this.context,
  );

  /// Context for localizations and snackbar showing.
  late final BuildContext context;

  /// Returns snackbar.
  SnackBar showSnackBar() {
    return SnackBar(
      duration: const Duration(seconds: 1),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: context.l10n.homeBottomNavBarTitle,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
      width: MediaQuery.of(context).size.width * 0.9,
      dismissDirection: DismissDirection.none,
    );
  }
}
