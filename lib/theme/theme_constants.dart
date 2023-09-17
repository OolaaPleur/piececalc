import 'package:flutter/material.dart';

/// Horizontal padding for text field.
const textFieldHorizontalPadding = 20.0;

/// Vertical padding for text field.
const textFieldVerticalPadding = 10.0;

/// SNACKBAR STYLE BELOW.
/// Snackbar padding.
const snackbarPadding = 10.0;
/// Snackbar duration.
const snackbarDuration = 3;
/// Color of remove icon in snackbar.
const snackbarRemoveIconColor = Colors.red;

/// TASK PAGE STYLE BELOW.
/// Padding when no tasks is present.
const emptyTasksPadding = 25.0;
/// Padding task list tile.
const listTilePadding = 10.0;

/// SETTINGS PAGE STYLE BELOW
/// General padding of all listTiles in settings page.
const settingsPadding = 20.0;
/// Padding of app info text.
const appInfoPadding = 16.0;

/// TASK EDITOR PAGE STYLE BELOW
const timePickerPadding = 10.0;

/// Icon padding.
const iconPadding = 10.0;

/// ADDWORK PAGE STYLE BELOW
/// Save button horizontal padding.
const saveButtonHorizontalPadding = 30.0;
/// Save button vertical padding.
const saveButtonVerticalPadding = 10.0;
/// Delete icon size.
const deleteIconSize = 30.0;

/// INTRO STYLE FORWARD.
/// Intro bottom color.
Color introBottomColor = Colors.red[300]!;

/// First intro page top color.
const Color introFirstPageTopColor = Color(0xFFfffad0);

/// Size of first from top SizedBox height.
const double firstSizeBoxHeight = 50;

/// Size of second from top SizedBox height.
const double secondSizeBoxHeight = 40;

/// Scale of title text.
const double introTitleTextScale = 1.7;

/// Scale of body text.
const double introBodyTextScale = 1.2;


/// Changed default textTheme styles.
final textThemeStyles = const TextTheme().copyWith(
  titleLarge: const TextStyle(
    fontSize: 21,
  ),
  labelSmall: const TextStyle(
    fontSize: 19,
  ),
);
