import 'package:flutter/material.dart';
import 'package:vazifa/model/currency_rate.dart';

class CurrencyDetailScreen extends StatefulWidget {
  final CurrencyRate currencyRate;

  const CurrencyDetailScreen({super.key, required this.currencyRate});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyDetailScreenState createState() => _CurrencyDetailScreenState();
}

class _CurrencyDetailScreenState extends State<CurrencyDetailScreen> {
  double? amountInUZS;

  void calculateAmount(String value) {
    if (value.isNotEmpty) {
      double amount = double.parse(value);
      setState(() {
        amountInUZS = amount * widget.currencyRate.rate;
      });
    } else {
      setState(() {
        amountInUZS = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currencyRate.title} - UZS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1 ${widget.currencyRate.title} = ${widget.currencyRate.rate} UZS',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Enter amount in ${widget.currencyRate.title}:',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: calculateAmount,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 20),
            if (amountInUZS != null)
              Text(
                'Equivalent in UZS: ${amountInUZS!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
