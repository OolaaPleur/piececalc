import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/data/earnings_chart.dart';
import 'package:piececalc/screens/settings/currency_picker/currency_picker_cubit.dart';
import 'package:piececalc/theme/theme.dart';

import '../../constants/constants.dart';
import '../../theme/theme_constants.dart';
import '../../utils/helpers.dart';
import '../settings/add_work/widgets/archived_header.dart';
import 'monthly_work_info_cubit.dart';

/// Represents a page that displays work-related information segmented by months.
///
/// This page provides a detailed view for users to analyze and understand their
/// work metrics for each month. It aggregates and organizes work data to offer
/// insights into monthly performance or productivity.
class MonthlyWorkInfo extends StatefulWidget {
  /// Constructor for [MonthlyWorkInfo].
  const MonthlyWorkInfo({super.key});

  @override
  State<MonthlyWorkInfo> createState() => _MonthlyWorkInfoState();
}

class _MonthlyWorkInfoState extends State<MonthlyWorkInfo> {
  late DateTime currentDate;
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

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

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
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
                      child: Scrollbar(
                        controller: scrollController,
                        thickness: 6,
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: scrollController,
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
                                          fontSize:
                                              Theme.of(context).textTheme.titleMedium!.fontSize,
                                        ),
                                      )
                                    : Text(
                                        '${context.l10n.timeSpent}: ${Helpers.formatDuration(workSummary.amount, context)}',
                                        style: TextStyle(
                                          fontSize:
                                              Theme.of(context).textTheme.titleMedium!.fontSize,
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
                    ),
                    const Divider(
                      thickness: 4,
                    ),
                    BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
                      builder: (context, currencyPickerState) {
                        return HeaderAndTooltip(
                          tooltipKey: tooltipKey,
                          tooltipText: context.l10n.chartGuideDaysOnTheXaxisMoneyEarnedOnThe,
                          title:
                              '${context.l10n.totalEarned}: '
                                  '${Helpers.formatNumber(monthlyWorkInfoState.totalCombinedPrice)}${currencyPickerState.currencyName['symbol']}',
                          isChart: true,
                        );
                      },
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 16, top: 30),
                        child: EarningsChart(),
                      ),
                    ),
                  ],
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
}
