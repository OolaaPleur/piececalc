import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/l10n/l10n.dart';
import 'package:piececalc/screens/settings/currency_picker/currency_picker_cubit.dart';

import '../../constants/constants.dart';
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
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                setState(() {
                  currentDate = DateTime(currentDate.year, currentDate.month - 1);
                });
                context
                    .read<MonthlyWorkInfoCubit>()
                    .loadData(month: currentDate.month, year: currentDate.year);
              },
            ),
            Text(
              '${monthToLocalKey[Month.values[currentDate.month - 1]]!(context.l10n)} ${currentDate.year}',
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: currentDate.month == DateTime.now().month &&
                      currentDate.year == DateTime.now().year
                  ? null
                  : () {
                      setState(() {
                        currentDate = DateTime(currentDate.year, currentDate.month + 1);
                      });
                      context
                          .read<MonthlyWorkInfoCubit>()
                          .loadData(month: currentDate.month, year: currentDate.year);
                    },
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<MonthlyWorkInfoCubit, MonthlyWorkInfoState>(
            builder: (context, monthlyWorkInfoState) {
              if (monthlyWorkInfoState is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (monthlyWorkInfoState is DataLoaded) {
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
                            title: Text(work.workName),
                            subtitle: Text('${workSummary.amount}'),
                            trailing: BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
                              builder: (context, currencyPickerState) {
                                if (currencyPickerState is CurrencyLoaded) {
                                  return Text(
                                    '${workSummary.combinedPrice}${currencyPickerState.currencyName['symbol']}',
                                  );
                                } else {
                                  return Text('${workSummary.combinedPrice}');
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (monthlyWorkInfoState is DataError) {
                return Center(child: Text('Error: ${monthlyWorkInfoState.error}'));
              }
              return const SizedBox.shrink(); // Fallback for unhandled states, if any
            },
          ),
        ),
      ],
    );
  }
}
