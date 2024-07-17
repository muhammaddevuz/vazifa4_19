import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa/logic/bloc.dart';
import 'package:vazifa/logic/bloc_observe.dart';
import 'package:vazifa/logic/events.dart';
import 'package:vazifa/logic/states.dart';
import 'package:vazifa/screens/currency_screen.dart';
import 'package:vazifa/service/currency_service.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) =>
            CurrencyBloc(CurrencyService())..add(FetchCurrencyRates()),
        child: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                context.read<CurrencyBloc>().add(SearchCurrency(query));
              },
              decoration: const InputDecoration(
                labelText: 'Search Currency',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CurrencyLoaded) {
                  return ListView.builder(
                    itemCount: state.rates.length,
                    itemBuilder: (context, index) {
                      final rate = state.rates[index];
                      return ListTile(
                        title: Text(rate.title),
                        subtitle: Text(rate.rate.toString()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CurrencyDetailScreen(
                                currencyRate: rate,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is CurrencyError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(
                      child: Text('Press the button to fetch rates.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
