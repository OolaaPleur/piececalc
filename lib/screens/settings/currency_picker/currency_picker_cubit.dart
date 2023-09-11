import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:get_it/get_it.dart';

import '../../../data/repositories/settings_repository.dart';

/// Represents the possible states for the [CurrencyPickerCubit].
abstract class CurrencyPickerState {
  /// Creates a [CurrencyPickerState] state.
  CurrencyPickerState({required this.currencyName});

  /// The [currencyName] represents the details of the currency.
  /// It can be empty or contain actual values.
  final Map<String, dynamic> currencyName;
}

/// The initial state for the [CurrencyPickerCubit].
///
/// This state represents the moment before any interaction or request
/// related to currency picking has been made.
class CurrencyInitial extends CurrencyPickerState {
  /// Creates a [CurrencyInitial] state.
  CurrencyInitial() : super(currencyName: {'name': '', 'symbol': ''});
}

/// Represents the state when currency data is being loaded.
class CurrencyLoading extends CurrencyPickerState {
  /// Creates a [CurrencyLoading] state.
  CurrencyLoading({required super.currencyName});
}

/// Represents the state when currency data has been successfully loaded.
///
/// Contains the name and details of the loaded currency.
class CurrencyLoaded extends CurrencyPickerState {
  /// Creates a [CurrencyLoaded] state.
  CurrencyLoaded({required super.currencyName});
}

/// A [Cubit] that manages the state for currency picking operations.
///
/// It communicates with a [SettingsRepository] to load currency information
/// and emits the relevant states as the currency data gets loaded.
class CurrencyPickerCubit extends Cubit<CurrencyPickerState> {
  /// Initializes the [CurrencyPickerCubit] with dependencies and initial state.
  ///
  /// Uses [GetIt] to obtain the [SettingsRepository] instance.
  CurrencyPickerCubit()
      : _settingsRepository = GetIt.I<SettingsRepository>(),
        super(CurrencyInitial());

  final SettingsRepository _settingsRepository;

  /// Initiates the loading process for the currency data.
  ///
  /// This method should be called when the app needs to fetch
  /// the current currency information. Depending on the result,
  /// this cubit will emit either [CurrencyLoading], [CurrencyLoaded], or
  /// another relevant state.
  Future<void> loadCurrency() async {
    emit(CurrencyLoading(currencyName: state.currencyName));
    final currencyJson = await _settingsRepository.getStringValue('currency');
    final currencyList = jsonDecode(currencyJson) as List<dynamic>;
    final firstCurrency = currencyList[0] as Map<String, dynamic>;
    final name = firstCurrency['name'] as String;
    final symbol = firstCurrency['symbol'] as String;
    emit(CurrencyLoaded(currencyName: {'name': name, 'symbol': symbol}));
  }
  /// Initiates the save process for the given currency.
  ///
  /// It will save the provided [currency] to shared preferences.
  ///
  /// [currency]: The currency object to be saved.
  Future<void> saveCurrency(Currency currency) async {
    final data = <String, dynamic>{
      'symbol': currency.symbol,
      'name': currency.name,
    };
    final savedWorks = <dynamic>[data];
    final updatedWorksJson = jsonEncode(savedWorks);
    await _settingsRepository.setStringValue('currency', updatedWorksJson);
    emit(CurrencyLoaded(currencyName: {'name': data['name'], 'symbol': data['symbol']}));
  }
}
