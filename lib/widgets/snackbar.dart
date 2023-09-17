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
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      duration: const Duration(seconds: snackbarDuration),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: message,
                style: const TextStyle(color: Colors.black),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: snackbarPadding),
              // adjust this value as needed
              child: Icon(
                Icons.close_outlined,
                color: Theme.of(context).colorScheme.error,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      //shape: const StadiumBorder(),
      //width: MediaQuery.of(context).size.width * 0.9,
      //dismissDirection: DismissDirection.down,
    );
  }
}
