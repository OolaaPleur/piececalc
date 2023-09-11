import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/data/models/composite_task_info.dart';

import '../../../constants/constants.dart';
import '../../../utils/helpers.dart';
import '../../settings/currency_picker/currency_picker_cubit.dart';

/// Widget, that shows price of task.
class PriceTextWidget extends StatelessWidget {
  /// Constructor for [PriceTextWidget].
  const PriceTextWidget({required this.taskInfo, super.key});

  /// Task and corresponding work info.
  final CompositeTaskInfo taskInfo;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
      builder: (context, currencyPickerState) {
        return taskInfo.work.paymentType == PaymentType.piecewisePayment.toString().split('.').last
            ? Text(
                '${Helpers.formatNumber(taskInfo.work.price * double.parse(taskInfo.completedTask.amount))}${currencyPickerState.currencyName['symbol']}',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  fontWeight: FontWeight.w400,
                ),
              )
            : Text(
                '${Helpers.formatNumber(Helpers.calculateEarnings(taskInfo.completedTask.amount, taskInfo.work.price))}${currencyPickerState.currencyName['symbol']}',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  fontWeight: FontWeight.w400,
                ),
              );
      },
    );
  }
}
