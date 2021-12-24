part of 'list_currencies_cubit.dart';

@immutable
abstract class ListCurrenciesState {}

class ListCurrenciesInitial extends ListCurrenciesState {}

class ListCurrenciesLoading extends ListCurrenciesState {}

class ListCurrenciesLoaded extends ListCurrenciesState {
  final ListCurrencies _items;
  final Set? _currencies;
  final String _currenciesString;

  ListCurrenciesLoaded({
    required ListCurrencies items,
    Set? currencies,
    required String currenciesString,
  })  : _items = items,
        _currenciesString = currenciesString,
        _currencies = currencies;

  ListCurrencies get items => _items;

  Set? get currencies => _currencies;

  String get currenciesString => _currenciesString;

  ListCurrenciesLoaded copyWith({
    ListCurrencies? items,
    Set? currencies,
    String? currenciesString,
  }) {
    return ListCurrenciesLoaded(
      items: items ?? _items,
      currenciesString: currenciesString ?? _currenciesString,
      currencies: currencies ?? _currencies,
    );
  }
}
