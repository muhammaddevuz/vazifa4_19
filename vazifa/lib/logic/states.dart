import 'package:vazifa/model/currency_rate.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<CurrencyRate> rates;

  CurrencyLoaded(this.rates);
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}
