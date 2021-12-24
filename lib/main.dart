import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platrum_project/repositories/exchange_currencies_repository.dart';
import 'package:platrum_project/repositories/list_currencies_repository.dart';
import 'package:platrum_project/screen/exchange_currencies/cubit/exchange_currencies_cubit.dart';
import 'package:platrum_project/screen/exchange_currencies/screen/exchange_currencies_screen.dart';
import 'package:platrum_project/screen/list_currencies/cubit/list_currencies_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ExchangeCurrenciesRepository()),
        RepositoryProvider(create: (_) => ListCurrenciesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ListCurrenciesCubit(
                listCurrenciesRepository:
                    context.read<ListCurrenciesRepository>()),
          ),
          BlocProvider(
            create: (context) => ExchangeCurrenciesCubit(
                exchangeCurrenciesRepository:
                    context.read<ExchangeCurrenciesRepository>()),
          ),
        ],
        child: const MaterialApp(home: ExchangeCurrenciesScreens()),
      ),
    );
  }
}
