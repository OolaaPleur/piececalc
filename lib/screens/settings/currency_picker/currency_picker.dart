import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piececalc/screens/settings/currency_picker/currency_picker_cubit.dart';

/// A widget that provides an interface for currency selection.
///
/// This widget displays options or UI components that allow users
/// to pick or select a currency. Its appearance and behavior might
/// vary based on the currency picker state maintained by a cubit.
class CurrencyPicker extends StatelessWidget {
  /// Creates an instance of [CurrencyPicker].
  const CurrencyPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          showCurrencyPicker(
            context: context,
            onSelect: (Currency currency) {
              context.read<CurrencyPickerCubit>().saveCurrency(currency);
            },
          );
        },
        title: const Text('change currency'),
        subtitle: BlocConsumer<CurrencyPickerCubit, CurrencyPickerState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CurrencyLoaded) {
              if (state.currencyName['name'] == 'none picked') {
                return const Text('None picked');
              }
              return Text('${state.currencyName['name']} - ${state.currencyName['symbol']}');
            }
            return const SizedBox.shrink();
          },
        ),
        leading: const Icon(Icons.currency_exchange),
        trailing: const Icon(Icons.keyboard_arrow_right),
        splashColor: Colors.transparent,
      ),
    );
  }
}
