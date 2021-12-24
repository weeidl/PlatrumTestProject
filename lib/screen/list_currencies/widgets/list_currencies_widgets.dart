import 'package:flutter/material.dart';
import 'package:platrum_project/screen/list_currencies/cubit/list_currencies_cubit.dart';

class ListCurrenciesWidgets extends StatefulWidget {
  final String current;
  final ListCurrenciesCubit listCurrenciesCubit;
  const ListCurrenciesWidgets({
    Key? key,
    required this.current,
    required this.listCurrenciesCubit,
  }) : super(key: key);

  @override
  State<ListCurrenciesWidgets> createState() => _ListCurrenciesWidgetsState();
}

class _ListCurrenciesWidgetsState extends State<ListCurrenciesWidgets> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var newString = widget.current.substring(widget.current.length - 3);
    var newS = widget.current.substring(0, 3);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 90,
        child: Column(
          children: [
            Row(
              children: [
                Text('$newS -> $newString'),
                const Spacer(),
                Checkbox(
                  checkColor: Colors.white,
                  value: isChecked,
                  onChanged: (bool? value) {
                    widget.listCurrenciesCubit
                        .toggleSelectionOne(widget.current);
                    widget.listCurrenciesCubit.currenciesString();
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              color: Colors.grey,
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
