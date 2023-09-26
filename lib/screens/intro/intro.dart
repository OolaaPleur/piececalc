import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/intro/pages/intro_fifth_page.dart';
import 'package:piececalc/screens/intro/pages/intro_first_page.dart';
import 'package:piececalc/screens/intro/pages/intro_sixth_page.dart';
import 'package:piececalc/screens/intro/pages/intro_third_page.dart';
import 'package:piececalc/theme/theme.dart';

import '../../data/repositories/settings_repository.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/theme_constants.dart';
import '../home/home.dart';
import 'pages/intro_fourth_page.dart';
import 'pages/intro_second_page.dart';
import 'pages/intro_seventh_page.dart';

/// Class, defines introduction screen for user, who use app for the first time.
class Intro extends StatelessWidget {
  /// Constructor for [Intro].
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: context.color.dotsContainerBottomColor,
      ),
    );
    return Scaffold(
      body: IntroductionScreen(
        nextSemantic: 'Next',
        backSemantic: 'Back',
        doneSemantic: 'Done',
        scrollPhysics: const ClampingScrollPhysics(),
        next: Icon(
          Icons.navigate_next,
          color: Theme.of(context).colorScheme.onPrimaryContainer, semanticLabel: 'Next',
        ),
        showBackButton: true,
        back: Icon(
          Icons.navigate_before,
          color: Theme.of(context).colorScheme.onPrimaryContainer, semanticLabel: 'Back',
        ),
        onDone: () async {
          final navigator = Navigator.of(context);
          final settingsRepository = GetIt.I<SettingsRepository>();
          await settingsRepository.setBoolValue('first_load', value: true);
          await navigator.pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (context) => const Home(),
            ),
            (Route<dynamic> route) => false,
          );
        },
        done: Text(
          key: const Key('intro_done_button'),
          context.l10n.done,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        dotsFlex: 2,
        dotsContainerDecorator: context.select((ThemeBloc bloc) => bloc.isDarkMode == true)
            ? const BoxDecoration(color: Color(0xFF141514))
            : BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    introBottomColor,
                    context.color.dotsContainerBottomColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
        dotsDecorator: context.select((ThemeBloc bloc) => bloc.isDarkMode == true)
            ? const DotsDecorator()
            : DotsDecorator(
                size: const Size.square(10),
                activeSize: const Size(20, 10),
                activeColor: Theme.of(context).colorScheme.secondary,
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
        pages: [
          introFirstPage(context),
          introSecondPage(context),
          introThirdPage(context),
          introFourthPage(context),
          introFifthPage(context),
          introSixthPage(context),
          introSeventhPage(context),
        ],
      ),
    );
  }
}
