import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platrum_project/models/list_currencies.dart';
import 'package:platrum_project/repositories/list_currencies_repository.dart';

part 'list_currencies_state.dart';

class ListCurrenciesCubit extends Cubit<ListCurrenciesState> {
  final ListCurrenciesRepository _listCurrenciesRepository;
  ListCurrenciesCubit(
      {required ListCurrenciesRepository listCurrenciesRepository})
      : _listCurrenciesRepository = listCurrenciesRepository,
        super(ListCurrenciesInitial());

  Future<void> fetch() async {
    if (state is ListCurrenciesInitial) {
      emit(ListCurrenciesLoading());
      final response = await _listCurrenciesRepository.fetchList();
      emit(ListCurrenciesLoaded(
        currenciesString: '',
        items: response,
        currencies: {},
      ));
    }
  }

  Future<void> currenciesString() async {
    final stateLoaded = state as ListCurrenciesLoaded;
    String finalStr = stateLoaded.currencies?.reduce((value, element) {
      return value + ',' + element;
    });
    emit(stateLoaded.copyWith(currenciesString: finalStr));
  }

  void toggleSelectionOne(String value) async {
    final stateLoaded = state as ListCurrenciesLoaded;
    stateLoaded.currencies?.add(value);
    emit(stateLoaded.copyWith());
  }

  Future<void> refresh() async {
    final stateLoaded = state as ListCurrenciesLoaded;
    final response = await _listCurrenciesRepository.fetchList();
    emit(stateLoaded.copyWith(items: response));
  }
}
