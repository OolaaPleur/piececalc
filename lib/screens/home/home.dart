import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/home/add_done_work/task_editor_bloc.dart';
import 'package:piececalc/screens/settings/settings.dart';
import 'package:share/share.dart';

import '../../data/models/composite_task_info.dart';
import '../../data/models/work.dart';
import '../../data/models/work_summary.dart';
import '../data/monthly_work_info.dart';
import '../data/monthly_work_info_cubit.dart';
import '../tasks/tasks.dart';
import 'add_done_work/task_editor.dart';
import 'home_bloc.dart';

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

  String generateCSV(
    Map<Work, WorkSummary> workData,
    List<CompositeTaskInfo> compositeTaskInfo,
  ) {
    // Step 1: Grouping the data
    final dateToWorkToAmount = <String, Map<String, int>>{};

    for (final composite in compositeTaskInfo) {
      final date = composite.completedTask.dateCreated;
      final workName = composite.work.workName;
      final amount = int.parse(composite.completedTask.amount);

      dateToWorkToAmount.putIfAbsent(date, () => {})[workName] =
          (dateToWorkToAmount[date]?[workName] ?? 0) + amount;
    }

    // Step 2: Get unique work names
    final workNames = workData.keys.map((work) => work.workName).toSet().toList();

    // Step 3: Generate rows for each date
    final rows = <List<String>>[];
    dateToWorkToAmount.forEach((date, workToAmount) {
      final row = <String>[date];
      for (final workName in workNames) {
        row.add(workToAmount[workName]?.toString() ?? '0');
      }
      rows.add(row);
    });

    // Sort rows by date
    rows.sort((a, b) => a[0].compareTo(b[0]));

// Step 4: Generate the "Total" row using WorkSummary
    final totalRow = <String>['Total'];
    for (final work in workData.keys) {
      totalRow.add(workData[work]!.amount.toString());
    }

    // Step 5: Generate the "Total sum" row using WorkSummary
    final totalSumRow = <String>['Total sum'];
    for (final work in workData.keys) {
      totalSumRow.add(workData[work]!.combinedPrice.toString());
    }

    // Step 6: Combine everything to generate the CSV
    final csv = StringBuffer()

    // Header
    ..writeln(['Date', ...workNames].join(','));

    // Rows
    for (final row in rows) {
      csv.writeln(row.join(','));
    }

    // Total and Total Sum Rows
    csv..writeln(totalRow.join(','))
    ..writeln(totalSumRow.join(','));

    return csv.toString();
  }

  Future<void> createBackupAndShare(
    Map<Work, WorkSummary> workData,
    List<CompositeTaskInfo> compositeTaskInfo,
  ) async {
    final doneWorksCSV = generateCSV(workData, compositeTaskInfo);

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/monthBackup.csv';

    final file = File(filePath);
    await file.writeAsString(doneWorksCSV);
    await Share.shareFiles(
      [filePath],
      subject: 'Backup of my data',
      text: 'Here is my month tasks backup from PieceCalc.',
    );
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  static const List<Widget> _pages = <Widget>[
    MonthlyWorkInfo(),
    Tasks(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PieceCa(lc)',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 20,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profileBottomNavBarTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: l10n.homeBottomNavBarTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.settingsBottomNavBarTitle,
          ),
        ],
        currentIndex: _activePage,
        //New
        onTap: (index) {
          _pageViewController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceOut,
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
                  return const Tooltip(
                    showDuration: Duration(seconds: 2),
                    triggerMode: TooltipTriggerMode.tap,
                    message: 'add works in settings',
                    child: FloatingActionButton(
                      backgroundColor: Colors.grey,
                      onPressed: null,
                      child: Icon(Icons.add),
                    ),
                  );
                }
                if (state is WorkDoneLengthMoreThanZero) {
                  return FloatingActionButton(
                    tooltip: 'Tap to add task',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) {
                            context.read<TaskEditorBloc>().add(LoadWorkEvent());
                            return const TaskEditor();
                          },
                        ),
                      );
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
                    onPressed: () {
                      createBackupAndShare(
                        monthlyWorkInfoState.workData,
                        monthlyWorkInfoState.compositeTaskInfo,
                      );
                    },
                    child: const Icon(Icons.share),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }
}
