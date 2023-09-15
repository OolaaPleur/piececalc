import 'package:fl_chart/fl_chart.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/currency_picker/currency_picker_cubit.dart';
import 'package:piececalc/theme/theme.dart';

import '../../constants/constants.dart';
import '../../data/models/composite_task_info.dart';
import '../../theme/theme_constants.dart';
import '../../utils/helpers.dart';
import 'monthly_work_info_cubit.dart';

/// Represents a page that displays work-related information segmented by months.
///
/// This page provides a detailed view for users to analyze and understand their
/// work metrics for each month. It aggregates and organizes work data to offer
/// insights into monthly performance or productivity.
class MonthlyWorkInfo extends StatefulWidget {
  /// Constructor for [MonthlyWorkInfo].
  MonthlyWorkInfo({super.key});

  @override
  State<MonthlyWorkInfo> createState() => _MonthlyWorkInfoState();

  final Color dark = const Color(0xFF50E4FF).darken(30);
  final Color normal = const Color(0xFF50E4FF).darken(30);
  final Color light = const Color(0xFF50E4FF);
}

class _MonthlyWorkInfoState extends State<MonthlyWorkInfo> {
  late DateTime currentDate;

  void goToNextMonth(BuildContext context) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    });
    context.read<MonthlyWorkInfoCubit>().loadData(month: currentDate.month, year: currentDate.year);
  }

  void goToPreviousMonth(BuildContext context) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);
    });
    context.read<MonthlyWorkInfoCubit>().loadData(month: currentDate.month, year: currentDate.year);
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Color(0xFF50E4FF),
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MonthlyWorkInfoCubit, MonthlyWorkInfoState>(
          builder: (context, state) {
            if (state is DataLoaded) {
              currentDate = DateTime(state.year, state.month);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: () => goToPreviousMonth(context),
                  ),
                  Text(
                    '${monthToLocalKey[Month.values[state.month - 1]]!(context.l10n, 0)} ${state.year}',
                    style: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: currentDate.month == DateTime.now().month &&
                            currentDate.year == DateTime.now().year
                        ? null
                        : () => goToNextMonth(context),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
        Expanded(
          child: BlocBuilder<MonthlyWorkInfoCubit, MonthlyWorkInfoState>(
            builder: (context, monthlyWorkInfoState) {
              if (monthlyWorkInfoState is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (monthlyWorkInfoState is DataLoaded) {
                final aggregatedData = <String, List<CompositeTaskInfo>>{};

                for (final taskInfo in monthlyWorkInfoState.compositeTaskInfo) {
                  final task = taskInfo.completedTask;
                  final dateTime = DateTime.parse(task.dateCreated);
                  final day = dateTime.day.toString();

                  if (!aggregatedData.containsKey(day)) {
                    aggregatedData[day] = [];
                  }
                  aggregatedData[day]!.add(taskInfo);
                }

                final barGroups = <BarChartGroupData>[];
                var index = 0;

                for (final entry in aggregatedData.entries) {
                  final rods = entry.value.map((taskInfo) {
                    return BarChartRodStackItem(
                      0,
                      double.parse(taskInfo.completedTask.amount),
                      taskInfo.work.workColor,
                    );
                  }).toList();

                  final totalAmount = entry.value.fold<double>(0, (sum, taskInfo) => sum + double.parse(taskInfo.completedTask.amount));

                  barGroups.add(
                    BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: totalAmount,
                          rodStackItems: rods,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  );
                  index++;
                }

                if (monthlyWorkInfoState.workData.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        child: ClipOval(child: Image.asset('assets/chart.png')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: appInfoPadding),
                        child: Text(context.l10n.noDataForThisMonth),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: monthlyWorkInfoState.workData.length,
                        itemBuilder: (ctx, index) {
                          final entry = monthlyWorkInfoState.workData.entries.elementAt(index);
                          final work = entry.key;
                          final workSummary = entry.value;

                          return ListTile(
                            title: Text(
                              work.workName,
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: iconPadding),
                              child: work.paymentType ==
                                      PaymentType.piecewisePayment.toString().split('.').last
                                  ? Text(
                                      '${context.l10n.amount}: ${Helpers.formatNumber(double.parse(workSummary.amount))}',
                                      style: TextStyle(
                                        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                                      ),
                                    )
                                  : Text(
                                      '${context.l10n.timeSpent}: ${Helpers.formatDuration(workSummary.amount, context)}',
                                      style: TextStyle(
                                        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                                      ),
                                    ),
                            ),
                            trailing: BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
                              builder: (context, currencyPickerState) {
                                return Text(
                                  '${context.l10n.earned}: ${Helpers.formatNumber(workSummary.combinedPrice)}${currencyPickerState.currencyName['symbol']}',
                                  style: TextStyle(
                                    color: context.color.moneyColor,
                                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: BarChart(
                          BarChartData(
                            barTouchData: barTouchData,
                            borderData: borderData,
                            gridData: const FlGridData(drawVerticalLine: false),
                            barGroups: barGroups,
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    final index = value.toInt();
                                    final style = TextStyle(
                                      color: const Color(0xFF50E4FF).darken(20),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    );
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(aggregatedData.keys.elementAt(index),style: style,),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  //getTitlesWidget: leftTitles,
                                ),
                              ),
                              topTitles: const AxisTitles(

                              ),
                              rightTitles: const AxisTitles(

                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    // AspectRatio(
                    //   aspectRatio: 1.66,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 16),
                    //     child: LayoutBuilder(
                    //       builder: (context, constraints) {
                    //         final barsSpace = 4.0 * constraints.maxWidth / 400;
                    //         final barsWidth = 8.0 * constraints.maxWidth / 400;
                    //         return BarChart(
                    //           BarChartData(
                    //             alignment: BarChartAlignment.center,
                    //             barTouchData: BarTouchData(
                    //               enabled: false,
                    //             ),
                    //             titlesData: FlTitlesData(
                    //               show: true,
                    //               bottomTitles: AxisTitles(
                    //                 sideTitles: SideTitles(
                    //                   showTitles: true,
                    //                   reservedSize: 28,
                    //                   getTitlesWidget: bottomTitles,
                    //                 ),
                    //               ),
                    //               leftTitles: AxisTitles(
                    //                 sideTitles: SideTitles(
                    //                   showTitles: true,
                    //                   reservedSize: 40,
                    //                   getTitlesWidget: leftTitles,
                    //                 ),
                    //               ),
                    //               topTitles: const AxisTitles(
                    //                 sideTitles: SideTitles(showTitles: false),
                    //               ),
                    //               rightTitles: const AxisTitles(
                    //                 sideTitles: SideTitles(showTitles: false),
                    //               ),
                    //             ),
                    //             gridData: FlGridData(
                    //               show: true,
                    //               checkToShowHorizontalLine: (value) => value % 10 == 0,
                    //               getDrawingHorizontalLine: (value) => FlLine(
                    //                 color: Colors.white54.withOpacity(0.1),
                    //                 strokeWidth: 1,
                    //               ),
                    //               drawVerticalLine: false,
                    //             ),
                    //             borderData: FlBorderData(
                    //               show: false,
                    //             ),
                    //             groupsSpace: barsSpace,
                    //             barGroups: getData(barsWidth, barsSpace),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // )
                  ,],
                );
              } else if (monthlyWorkInfoState is DataError) {
                return Center(child: Text(context.l10n.somethingWentWrong));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000, widget.dark),
              BarChartRodStackItem(2000000000, 12000000000, widget.normal),
              BarChartRodStackItem(12000000000, 17000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 24000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 13000000000, widget.dark),
              BarChartRodStackItem(13000000000, 14000000000, widget.normal),
              BarChartRodStackItem(14000000000, 24000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 23000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000.5, widget.dark),
              BarChartRodStackItem(6000000000.5, 18000000000, widget.normal),
              BarChartRodStackItem(18000000000, 23000000000.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 29000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.dark),
              BarChartRodStackItem(9000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 29000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 32000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000.5, widget.dark),
              BarChartRodStackItem(2000000000.5, 17000000000.5, widget.normal),
              BarChartRodStackItem(17000000000.5, 32000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 31000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 11000000000, widget.dark),
              BarChartRodStackItem(11000000000, 18000000000, widget.normal),
              BarChartRodStackItem(18000000000, 31000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 35000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 14000000000, widget.dark),
              BarChartRodStackItem(14000000000, 27000000000, widget.normal),
              BarChartRodStackItem(27000000000, 35000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 31000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 8000000000, widget.dark),
              BarChartRodStackItem(8000000000, 24000000000, widget.normal),
              BarChartRodStackItem(24000000000, 31000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 15000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000.5, widget.dark),
              BarChartRodStackItem(6000000000.5, 12000000000.5, widget.normal),
              BarChartRodStackItem(12000000000.5, 15000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 17000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.dark),
              BarChartRodStackItem(9000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 17000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 34000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000, widget.dark),
              BarChartRodStackItem(6000000000, 23000000000, widget.normal),
              BarChartRodStackItem(23000000000, 34000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 32000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.dark),
              BarChartRodStackItem(7000000000, 24000000000, widget.normal),
              BarChartRodStackItem(24000000000, 32000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 14000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 1000000000.5, widget.dark),
              BarChartRodStackItem(1000000000.5, 12000000000, widget.normal),
              BarChartRodStackItem(12000000000, 14000000000.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 20000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 4000000000, widget.dark),
              BarChartRodStackItem(4000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 20000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 24000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 4000000000, widget.dark),
              BarChartRodStackItem(4000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 24000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 14000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 1000000000.5, widget.dark),
              BarChartRodStackItem(1000000000.5, 12000000000, widget.normal),
              BarChartRodStackItem(12000000000, 14000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 27000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.dark),
              BarChartRodStackItem(7000000000, 25000000000, widget.normal),
              BarChartRodStackItem(25000000000, 27000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 29000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000, widget.dark),
              BarChartRodStackItem(6000000000, 23000000000, widget.normal),
              BarChartRodStackItem(23000000000, 29000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 16000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.dark),
              BarChartRodStackItem(9000000000, 15000000000, widget.normal),
              BarChartRodStackItem(15000000000, 16000000000.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 15000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.dark),
              BarChartRodStackItem(7000000000, 12000000000.5, widget.normal),
              BarChartRodStackItem(12000000000.5, 15000000000, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }
}
