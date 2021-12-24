class ExchangeCurrencies {
  final String message;
  final int status;
  final Map<String, dynamic> data;

  ExchangeCurrencies(
      {required this.message, required this.data, required this.status});

  factory ExchangeCurrencies.fromJson(Map<dynamic, dynamic> json) {
    return ExchangeCurrencies(
      message: json['message'],
      status: json['status'],
      data: json['data'],
    );
  }
}
