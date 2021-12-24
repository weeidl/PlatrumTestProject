import 'dart:convert';

import 'package:http/retry.dart';
import 'package:http/http.dart' as http;
import 'package:platrum_project/models/key.dart';
import 'package:platrum_project/models/list_currencies.dart';

class ListCurrenciesRepository {
  Future<ListCurrencies> fetchList() async {
    final client = RetryClient(http.Client());
    final response = await client
        .get(Uri.parse('https://currate.ru/api/?get=currency_list&key=$key'));
    final ListCurrencies items;
    items = ListCurrencies.fromJson(jsonDecode(response.body));
    return items;
  }
}
