import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/theme_constants.dart';
/// Seventh page of intro.
PageViewModel introSeventhPage(BuildContext context) {
  return PageViewModel(
    decoration: context.select((ThemeBloc bloc) => bloc.isDarkMode == true)
        ? const PageDecoration()
        : PageDecoration(
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFffed51), introBottomColor],
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
            'assets/intro/intro_seventh_page.png',
            semanticLabel: 'Space rocket and calculator at bottom of the rocket',
            scale: 6,
          ),
        ),
        const SizedBox(
          height: secondSizeBoxHeight,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            AppLocalizations.of(context)!.introSixthScreenHeader,
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
            AppLocalizations.of(context)!.introSixthScreenBody,
            textScaleFactor: introBodyTextScale,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
