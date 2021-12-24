import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platrum_project/screen/exchange_currencies/cubit/exchange_currencies_cubit.dart';
import 'package:platrum_project/screen/list_currencies/cubit/list_currencies_cubit.dart';
import 'package:platrum_project/screen/list_currencies/widgets/list_currencies_widgets.dart';

class ListCurrenciesScreens extends StatelessWidget {
  const ListCurrenciesScreens({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ListCurrenciesScreens(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListCurrenciesCubit, ListCurrenciesState>(
        builder: (context, state) {
          if (state is ListCurrenciesInitial) {
            context.read<ListCurrenciesCubit>().fetch();
          }
          if (state is ListCurrenciesLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[50],
                elevation: 0,
                leadingWidth: 0,
                bottom: const PreferredSize(
                  preferredSize: Size.square(8.0),
                  child: Divider(
                    height: 8,
                    color: Colors.black,
                  ),
                ),
                title: const Text(
                  'Курсы валют',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      context
                          .read<ExchangeCurrenciesCubit>()
                          .addCurrencies(state.currenciesString);
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(
                          'Добавить',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: RefreshIndicator(
                  child: CustomScrollView(
                    slivers: [
                      // const SliverToBoxAdapter(),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return SafeArea(
                              child: ListCurrenciesWidgets(
                                current: state.items.data.elementAt(index),
                                listCurrenciesCubit:
                                    context.read<ListCurrenciesCubit>(),
                              ),
                            );
                          },
                          childCount: 10,
                        ),
                      ),
                    ],
                  ),
                  onRefresh: context.read<ListCurrenciesCubit>().refresh,
                ),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
