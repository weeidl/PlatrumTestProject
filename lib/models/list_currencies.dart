class ListCurrencies {
  final String message;
  final String status;
  final List<dynamic> data;

  ListCurrencies(
      {required this.message, required this.data, required this.status});

  factory ListCurrencies.fromJson(Map<String, dynamic> json) {
    return ListCurrencies(
      message: json['message'],
      status: json['status'],
      data: json['data'],
    );
  }
}
