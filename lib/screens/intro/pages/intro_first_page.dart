import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:piececalc/l10n/l10n.dart';

import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/theme_constants.dart';

/// First page of intro.
PageViewModel introFirstPage (BuildContext context) {
  return PageViewModel(
    decoration: context.select((ThemeBloc bloc) => bloc.isDarkMode == true)
        ? const PageDecoration()
        : PageDecoration(
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [introFirstPageTopColor, introBottomColor],
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
            'assets/launcher_icon.png',
            semanticLabel: 'Launcher icon, todo list with big tick symbol',
            scale: 6,
          ),
        ),
        const SizedBox(
          height: secondSizeBoxHeight,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            context.l10n.introFirstScreenHeader,
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
           context.l10n.introFirstScreenBody,
            textScaleFactor: introBodyTextScale,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
