import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platrum_project/models/exchange_currencies.dart';
import 'package:platrum_project/repositories/exchange_currencies_repository.dart';

part 'exchange_currencies_state.dart';

class ExchangeCurrenciesCubit extends Cubit<ExchangeCurrenciesState> {
  final ExchangeCurrenciesRepository _exchangeCurrenciesRepository;
  ExchangeCurrenciesCubit(
      {required ExchangeCurrenciesRepository exchangeCurrenciesRepository})
      : _exchangeCurrenciesRepository = exchangeCurrenciesRepository,
        super(ExchangeCurrenciesInitial());

  Future<void> fetch() async {
    if (state is ExchangeCurrenciesInitial) {
      emit(ExchangeCurrenciesLoading());
      final response = await _exchangeCurrenciesRepository.fetchPost();
      emit(ExchangeCurrenciesLoaded(
        items: (response != true) ? response : null,
        currencies: '',
      ));
    }
  }

  Future<void> addCurrencies(String currencies) async {
    final stateLoaded = state as ExchangeCurrenciesLoaded;
    if (currencies != '') {
      final response =
          await _exchangeCurrenciesRepository.fetchPost(currencies: currencies);
      emit(stateLoaded.copyWith(items: response, currencies: currencies));
    }
  }

  Future<void> refresh() async {
    final stateLoaded = state as ExchangeCurrenciesLoaded;
    final response = await _exchangeCurrenciesRepository.fetchPost(
        currencies: stateLoaded.currencies);
    emit(stateLoaded.copyWith(items: response));
  }
}
