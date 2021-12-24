part of 'exchange_currencies_cubit.dart';

@immutable
abstract class ExchangeCurrenciesState {}

class ExchangeCurrenciesInitial extends ExchangeCurrenciesState {}

class ExchangeCurrenciesLoading extends ExchangeCurrenciesState {}

class ExchangeCurrenciesLoaded extends ExchangeCurrenciesState {
  final ExchangeCurrencies? _items;
  final String? _currencies;

  ExchangeCurrenciesLoaded({
    required ExchangeCurrencies? items,
    String? currencies,
  })  : _items = items,
        _currencies = currencies;

  ExchangeCurrencies? get items => _items;

  String? get currencies => _currencies;

  ExchangeCurrenciesLoaded copyWith({
    ExchangeCurrencies? items,
    String? currencies,
  }) {
    return ExchangeCurrenciesLoaded(
      items: items ?? _items,
      currencies: currencies ?? _currencies,
    );
  }
}
