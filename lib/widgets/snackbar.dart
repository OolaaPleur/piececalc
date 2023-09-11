import 'package:flutter/material.dart';
import 'package:piececalc/theme/theme_constants.dart';

/// Class, defines how snackbar look like in app.
class AppSnackBar {
  /// Constructor for [AppSnackBar].
  AppSnackBar(this.context, {this.message});

  /// Context for localizations and snackbar showing.
  late final BuildContext context;

  /// Message to display.
  late final String? message;

  /// Returns snackbar.
  SnackBar showSnackBar() {
    return SnackBar(
      duration: const Duration(seconds: snackbarDuration),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: message,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: snackbarPadding), // adjust this value as needed
              child: Icon(
                Icons.close,
                color: snackbarRemoveIconColor,
              ),
            ),
          ),
        ],
      ),
      //shape: const StadiumBorder(),
      //width: MediaQuery.of(context).size.width * 0.9,
      dismissDirection: DismissDirection.none,
    );
  }
}
