class CurrencyRate {
  final String title;
  final double rate;

  CurrencyRate({required this.title, required this.rate});

  factory CurrencyRate.fromJson(Map<String, dynamic> json) {
    return CurrencyRate(
      title: json['title'],
      rate: double.parse(json['cb_price']),
    );
  }
}
