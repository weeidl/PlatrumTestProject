import 'package:flutter/material.dart';

class ExchangeCurrenciesWidgets extends StatelessWidget {
  final String currentName;
  final String currentNum;
  const ExchangeCurrenciesWidgets(
      {Key? key, required this.currentName, required this.currentNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var newString = currentName.substring(currentName.length - 3);
    var newS = currentName.substring(0, 3);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Text('$newS -> $newString'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(currentNum),
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
    );
  }
}
