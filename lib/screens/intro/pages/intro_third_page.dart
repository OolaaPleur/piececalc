import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../l10n/app_localizations.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/theme_constants.dart';
/// Third page of intro.
PageViewModel introThirdPage(BuildContext context) {
  return PageViewModel(
    decoration: context.select((ThemeBloc bloc) => bloc.isDarkMode == true)
        ? const PageDecoration()
        : PageDecoration(
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFFFf7aa), introBottomColor],
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
            'assets/intro/intro_third_page.png',
            semanticLabel: 'Calendar with big magnifying glass',
            scale: 6,
          ),
        ),
        const SizedBox(
          height: secondSizeBoxHeight,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            AppLocalizations.of(context)!.introSecondAndHalfScreenHeader,
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
            AppLocalizations.of(context)!.introSecondAndHalfScreenBody,
            textScaleFactor: introBodyTextScale,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
