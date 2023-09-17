import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/theme_constants.dart';
import '../../settings/theme_switch/theme_segmented_buttons.dart';

/// Fifth page of intro.
PageViewModel introFifthPage(BuildContext context) {
  return PageViewModel(
    decoration: context.select((ThemeBloc bloc) => bloc.isDarkMode == true)
        ? const PageDecoration()
        : PageDecoration(
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFfff284), introBottomColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
    titleWidget: Column(
      children: [
        const SizedBox(
          height: firstSizeBoxHeight,
        ),
        ClipOval(
          child: Image.asset(
            'assets/intro/intro_theme_change.png',
            scale: 6,
          ),
        ),
        const SizedBox(
          height: secondSizeBoxHeight,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            context.l10n.introFifthScreenHeader,
            textScaleFactor: introTitleTextScale,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    bodyWidget: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            context.l10n.introFifthScreenBody,
            textScaleFactor: introBodyTextScale,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: context.select((ThemeBloc bloc) => bloc.isDarkMode == true)
                ? const BoxDecoration()
                : BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red[200]!, introBottomColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
            child: const ThemeSegmentedButtons(),
          ),
        ),
      ],
    ),
  );
}
