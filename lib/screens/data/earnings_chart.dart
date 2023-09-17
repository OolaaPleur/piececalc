import 'package:fl_chart/fl_chart.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/composite_task_info.dart';
import '../../utils/helpers.dart';
import '../settings/currency_picker/currency_picker_cubit.dart';
import 'monthly_work_info_cubit.dart';

/// Widget, defines earnings chart.
class EarningsChart extends StatelessWidget {
  /// Constructor for [EarningsChart].
  const EarningsChart({super.key});

  /// Left tiles of chart.
  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    return BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
      builder: (context, currencyPickerState) {
        return SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(
            '${meta.formattedValue}${currencyPickerState.currencyName['symbol']}',
          ),
        );
      },
    );
  }

  FlBorderData get _borderData =>
      FlBorderData(
        show: false,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlyWorkInfoCubit, MonthlyWorkInfoState>(
      builder: (context, monthlyWorkInfoState) {
        if (monthlyWorkInfoState is DataLoaded) {
          var aggregatedData = <int, List<CompositeTaskInfo>>{};

          for (final taskInfo in monthlyWorkInfoState.compositeTaskInfo) {
            final task = taskInfo.completedTask;
            final dateTime = DateTime.parse(task.dateCreated);
            final day = dateTime.day;

            if (!aggregatedData.containsKey(day)) {
              aggregatedData[day] = [];
            }
            aggregatedData[day]!.add(taskInfo);
          }

          aggregatedData = Map.fromEntries(
            aggregatedData.entries.toList()
              ..sort((a, b) => a.key.compareTo(b.key)),
          );

          final barGroups = <BarChartGroupData>[];
          var index = 0;

          for (final entry in aggregatedData.entries) {
            var totalEarnings = 0.0;
            var accumulatedEarning = 0.0;

            // Group tasks by work id
            final groupedTasks = <String, List<CompositeTaskInfo>>{};
            for (final taskInfo in entry.value) {
              final workId = taskInfo.work.id;
              if (!groupedTasks.containsKey(workId)) {
                groupedTasks[workId] = [];
              }
              groupedTasks[workId]!.add(taskInfo);
            }

            // Sort grouped tasks by work id for consistent order
            final orderedTasks = groupedTasks.entries.toList()
              ..sort((a, b) => a.key.compareTo(b.key));

            final rods = <BarChartRodStackItem>[];

            // Compute rod stack items for each group
            for (final group in orderedTasks) {
              for (final taskInfo in group.value) {
                double earning;

                if (taskInfo.work.paymentType == 'hourlyPayment') {
                  earning =
                      Helpers.calculateEarnings(taskInfo.completedTask.amount, taskInfo.work.price);
                } else {
                  // Assuming 'piecewisePayment'
                  earning = double.parse(taskInfo.completedTask.amount) * taskInfo.work.price;
                }

                rods.add(
                  BarChartRodStackItem(
                    accumulatedEarning, // Start value
                    accumulatedEarning + earning, // End value
                    taskInfo.work.workColor,
                  )
                  ,);

                accumulatedEarning += earning;
                totalEarnings += earning;
              }
            }

            barGroups.add(
              BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: totalEarnings,
                    rodStackItems: rods,
                  ),
                ],
                showingTooltipIndicators: [0],
              )
              ,);
            index++;
          }


          return BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
            builder: (context, currencyPickerState) {
              return BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    enabled: false,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipPadding: EdgeInsets.zero,
                      tooltipMargin: 8,
                      getTooltipItem: (BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,) {
                        return BarTooltipItem(
                          '${rod.toY.round()}${currencyPickerState.currencyName['symbol']}',
                          const TextStyle(
                            color: Color(0xFF50E4FF),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  borderData: _borderData,
                  gridData: const FlGridData(drawVerticalLine: false),
                  barGroups: barGroups,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final index = value.toInt();
                          final style = TextStyle(
                            color: const Color(0xFF50E4FF).darken(20),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          );
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              aggregatedData.keys.elementAt(index).toString(),
                              style: style,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
