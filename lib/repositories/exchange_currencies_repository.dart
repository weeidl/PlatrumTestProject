import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:platrum_project/models/exchange_currencies.dart';
import 'package:platrum_project/models/key.dart';

class ExchangeCurrenciesRepository {
  fetchPost({String? currencies}) async {
    final pairs = currencies != null ? '&pairs=$currencies' : null;
    final client = RetryClient(http.Client());
    final response = await client
        .get(Uri.parse('https://currate.ru/api/?get=rates$pairs&key=$key'));
    try {
      final ExchangeCurrencies items;
      items = ExchangeCurrencies.fromJson(jsonDecode(response.body));
      return items;
    } catch (error) {
      return response.body.isNotEmpty;
    }
  }
}
