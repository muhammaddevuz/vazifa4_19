abstract class CurrencyEvent {}

class FetchCurrencyRates extends CurrencyEvent {}

class SearchCurrency extends CurrencyEvent {
  final String query;

  SearchCurrency(this.query);
}
