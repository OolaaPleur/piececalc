import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/backup/bloc/file_picking_bloc.dart';
import 'package:piececalc/screens/settings/settings.dart';
import '../../constants/constants.dart';
import '../../utils/navigation.dart';
import '../../widgets/snackbar.dart';
import '../data/monthly_work_info.dart';
import '../data/monthly_work_info_cubit.dart';
import '../settings/add_work/cubit/add_work_cubit.dart';
import '../tasks/tasks.dart';
import 'bloc/home_bloc.dart';

/// [Home] widget serves as the main screen of the application.
///
/// This screen provides a centralized point for navigating to
/// different parts of the application. The stateful nature of this widget
/// ensures that changes in its child widgets can be reflected in real-time
/// without having to rebuild the entire widget tree.
///
/// See also:
///  * [_HomeState], which is the state object for this widget.
class Home extends StatefulWidget {
  /// Creates a [Home] widget.
  ///
  /// This constructor is typically used for creating the root widget
  /// of the application that handles the main navigation.
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageViewController = PageController(initialPage: 1);

  int _activePage = 1;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    precacheImage(Image.asset('assets/chart.png').image, context);
    precacheImage(Image.asset('assets/empty_archive.png').image, context);
    super.didChangeDependencies();
  }

  static final List<Widget> _pages = <Widget>[
    const MonthlyWorkInfo(),
    const Tasks(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddWorkCubit, AddWorkState>(
          listener: (context, state) {
            if (state is WorkDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(context, message: context.l10n.workDeleted).showSnackBar(),
              );
            }
            if (state is WorkCantBeDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(context, message: context.l10n.workIsAlreadyUsedInTaskCantDelete)
                    .showSnackBar(),
              );
            }
          },
        ),
        BlocListener<FilePickingBloc, FilePickingState>(
          listener: (context, state) {
            if (state.status == FilePickingStatus.pickedOther) {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(context, message: context.l10n.fileIsNotCorrect).showSnackBar(),
              );
            }
            if (state.status == FilePickingStatus.dataUploaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(context, message: context.l10n.dataSuccessfullyUploadedToApp).showSnackBar(),
              );
            }
            if (state.status == FilePickingStatus.fileIsNotBackup) {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(context, message: context.l10n.fileIsDamaged).showSnackBar(),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.l10n.piececalc,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedFontSize: Theme.of(context).textTheme.titleLarge!.fontSize ?? 20,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: context.l10n.statsBottomNavBarTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: context.l10n.homeBottomNavBarTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: context.l10n.settingsBottomNavBarTitle,
            ),
          ],
          currentIndex: _activePage,
          //New
          onTap: (index) {
            final curve = (index - _activePage).abs() == 1 ? Curves.easeInOut : Curves.linear;
            _pageViewController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: curve,
            );
          },
        ),
        body: PageView(
          controller: _pageViewController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _activePage = index;
            });
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_activePage == 1)
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is WorkDoneLengthEqualsZero) {
                    return Tooltip(
                      showDuration: const Duration(seconds: 2),
                      triggerMode: TooltipTriggerMode.tap,
                      message: context.l10n.addWorksInSettings,
                      child: const FloatingActionButton(
                        backgroundColor: Colors.grey,
                        onPressed: null,
                        child: Icon(Icons.add),
                      ),
                    );
                  }
                  if (state is WorkDoneLengthMoreThanZero) {
                    return FloatingActionButton(
                      tooltip: context.l10n.tapToAddTask,
                      onPressed: () {
                        Navigation.navigateToTaskEditor(context);
                      },
                      child: const Icon(Icons.add),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            else if (_activePage == 0)
              BlocBuilder<MonthlyWorkInfoCubit, MonthlyWorkInfoState>(
                builder: (context, monthlyWorkInfoState) {
                  if (monthlyWorkInfoState is DataLoaded) {
                    return FloatingActionButton(
                      tooltip: context.l10n.shareMonthData,
                      onPressed: monthlyWorkInfoState.workData.isEmpty
                          ? null
                          : () {
                              context.read<MonthlyWorkInfoCubit>().createBackup(
                                    monthlyWorkInfoState.workData,
                                    monthlyWorkInfoState.compositeTaskInfo,
                                    shareSubject: 'Backup of my data',
                                    shareText: context.l10n.shareSubjectText(
                                      '${monthToLocalKey[Month.values[monthlyWorkInfoState.month - 1]]!(context.l10n, 0)} ${monthlyWorkInfoState.year}',
                                    ),
                                  );
                            },
                      backgroundColor: monthlyWorkInfoState.workData.isEmpty ? Colors.grey : null,
                      child: const Icon(Icons.share),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
          ],
        ),
      ),
    );
  }
}
