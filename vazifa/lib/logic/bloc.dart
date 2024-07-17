import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vazifa/logic/events.dart';
import 'package:vazifa/logic/states.dart';
import 'package:vazifa/service/currency_service.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyService currencyService;

  CurrencyBloc(this.currencyService) : super(CurrencyInitial()) {
    on<FetchCurrencyRates>(_onFetchCurrencyRates);
    on<SearchCurrency>(
      _onSearchCurrency,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  void _onFetchCurrencyRates(
      FetchCurrencyRates event, Emitter<CurrencyState> emit) async {
    emit(CurrencyLoading());
    try {
      final rates = await currencyService.fetchCurrencyRates();
      emit(CurrencyLoaded(rates));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }

  void _onSearchCurrency(
      SearchCurrency event, Emitter<CurrencyState> emit) async {
    final currentState = state;
    if (currentState is CurrencyLoaded) {
      final filteredRates = currentState.rates
          .where((rate) => rate.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(CurrencyLoaded(filteredRates));
    }
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }
}
