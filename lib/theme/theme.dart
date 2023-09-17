import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:piececalc/theme/theme_constants.dart';

import 'theme_colors.dart';

/// Extension on BuildContext, to make shorter call.
extension BuildContextExt on BuildContext {
  /// Extension, to get shorter call for predefined colors.
  ThemeColors get color => Theme.of(this).extension<ThemeColors>()!;
}

/// App theme choices.
class FlutterAppTheme {
  /// Light theme.
  static ThemeData light() {
    return FlexThemeData.light(
      error: const Color(0xffbf324c),
      textTheme: textThemeStyles,
      extensions: <ThemeExtension<dynamic>>[
        ThemeColors.light(),
      ],
      scheme: FlexScheme.mango,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      //fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  /// Dark theme.
  static ThemeData dark() {
    return FlexThemeData.dark(
      error: const Color(0xffbf324c),
      textTheme: textThemeStyles,
      extensions: <ThemeExtension<dynamic>>[
        ThemeColors.dark(),
      ],
      scheme: FlexScheme.mango,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      //fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }
}
