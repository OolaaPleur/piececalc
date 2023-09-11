import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piececalc/theme/theme_constants.dart';

/// Extension on BuildContext, to make shorter call.
extension BuildContextExt on BuildContext {}

/// App theme choices.
class FlutterAppTheme {
  /// Light theme.
  static ThemeData light() {
    return FlexThemeData.light(
      //textTheme: titleMediumTextTheme,//TODO remove when stop editing next lines on texttheme
      textTheme: const TextTheme().copyWith(
        // titleMedium: const TextStyle(
        //   fontSize: 16,
        // ),
        titleLarge: const TextStyle(
          fontSize: 21,
        ),
        labelSmall: const TextStyle(
          fontSize: 19,
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[
        //ThemeColors.light(),
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
      fontFamily: 'NotoSans',
    );
  }

  /// Dark theme.
  static ThemeData dark() {
    return FlexThemeData.dark(
      textTheme: textThemeStyles,
      extensions: <ThemeExtension<dynamic>>[
        //ThemeColors.dark(),
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
      fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }
}
