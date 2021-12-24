import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platrum_project/screen/exchange_currencies/cubit/exchange_currencies_cubit.dart';
import 'package:platrum_project/screen/exchange_currencies/widgets/exchange_currencies_widgets.dart';
import 'package:platrum_project/screen/list_currencies/screen/list_currencies_screen.dart';

class ExchangeCurrenciesScreens extends StatelessWidget {
  const ExchangeCurrenciesScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text(
          'Курсы валют',
          style: TextStyle(color: Colors.black),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.square(8.0),
          child: Divider(
            height: 8,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(context, ListCurrenciesScreens.route()),
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ExchangeCurrenciesCubit, ExchangeCurrenciesState>(
          builder: (context, state) {
        if (state is ExchangeCurrenciesInitial) {
          context.read<ExchangeCurrenciesCubit>().fetch();
        }
        if (state is ExchangeCurrenciesLoaded) {
          Future.delayed(const Duration(minutes: 10), () {
            context.read<ExchangeCurrenciesCubit>().refresh();
          });
          return (state.items != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: RefreshIndicator(
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              _deleteMessage(index) {
                                state.items!.data.remove(index);
                              }

                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                resizeDuration:
                                    const Duration(milliseconds: 200),
                                key: ObjectKey(
                                    state.items!.data.keys.elementAt(index)),
                                onDismissed: (direction) {
                                  _deleteMessage(index);
                                },
                                background: Container(
                                  padding: const EdgeInsets.only(right: 28.0),
                                  alignment: AlignmentDirectional.centerEnd,
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                  ),
                                ),
                                // secondaryBackground: ...,
                                child: ExchangeCurrenciesWidgets(
                                  currentName:
                                      state.items!.data.keys.elementAt(index),
                                  currentNum:
                                      state.items!.data.values.elementAt(index),
                                ),
                              );
                            },
                            childCount: state.items!.data.length,
                          ),
                        ),
                      ],
                    ),
                    onRefresh: context.read<ExchangeCurrenciesCubit>().refresh,
                  ),
                )
              : const Center(
                  child: Text(
                    'Нет добавленных валют',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
