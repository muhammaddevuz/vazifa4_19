import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vazifa/model/currency_rate.dart';

class CurrencyService {
  Future<List<CurrencyRate>> fetchCurrencyRates() async {
    final response = await http.get(Uri.parse('https://nbu.uz/uz/exchange-rates/json/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CurrencyRate.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load currency rates');
    }
  }
}
