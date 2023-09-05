import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/data/monthly_work_info_cubit.dart';
import '../screens/home/add_done_work/task_editor_bloc.dart';
import '../screens/home/home.dart';
import '../screens/home/home_bloc.dart';
import '../screens/settings/add_work/add_work_cubit.dart';
import '../screens/settings/currency_picker/currency_picker_cubit.dart';
import '../screens/settings/language_change/language_cubit.dart';
import '../screens/tasks/tasks_bloc.dart';
import '../theme/bloc/theme_bloc.dart';

/// Entry widget of the app.
class App extends StatefulWidget {
  /// Entry widget constructor.
  const App({super.key, this.locale});

  /// Set locale, used for TEST ONLY.
  final Locale? locale;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc()..add(LoadThemeEvent()),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => TasksCubit()..loadData(),
        ),
        BlocProvider(
          create: (context) => TaskEditorBloc()..add(LoadWorkEvent()),
        ),
        BlocProvider(
          create: (_) => CurrencyPickerCubit()..loadCurrency(),
        ),
        BlocProvider(
          create: (_) =>
              MonthlyWorkInfoCubit()..loadData(month: currentDate.month, year: currentDate.year),
        ),
        BlocProvider(
          create: (context) => AddWorkCubit()..loadWorks(),
        ),
        BlocProvider(
          create: (context) => HomeBloc()..add(CheckIfAnyWorkExistsEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CurrencyPickerCubit, CurrencyPickerState>(
            listener: (context, state) {
              if (state is CurrencyLoaded) {
                context.read<TasksCubit>().loadData();
              }
            },
          ),
          BlocListener<TasksCubit, TasksState>(
            listener: (context, state) {
              if (state is TaskDeleted) {
                context
                    .read<MonthlyWorkInfoCubit>()
                    .loadData(month: currentDate.month, year: currentDate.year);
              }
            },
          ),
          BlocListener<AddWorkCubit, AddWorkState>(
            listener: (context, state) {
              if (state is WorkSaved) {
                context.read<TaskEditorBloc>().add(LoadWorkEvent());
              }
            },
          ),
          BlocListener<AddWorkCubit, AddWorkState>(
            listener: (context, state) {
              if (state is WorksLoaded) {
                context.read<HomeBloc>().add(CheckIfAnyWorkExistsEvent());
              }
            },
          ),
          BlocListener<TaskEditorBloc, TaskEditorState>(
            listener: (context, state) {
              if (state is TaskSaved) {
                context
                    .read<MonthlyWorkInfoCubit>()
                    .loadData(month: currentDate.month, year: currentDate.year);
              }
            },
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, theme) {
            return MaterialApp(
              locale: widget.locale ?? context.watch<LanguageCubit>().state,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                return supportedLocales.contains(deviceLocale)
                    ? deviceLocale
                    : supportedLocales.first;
              },
              theme: theme.themeData,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const Home(),
            );
          },
        ),
      ),
    );
  }
}
