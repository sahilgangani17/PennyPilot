import 'package:flutter/material.dart';
class Currencyconvertor extends StatefulWidget {
  const Currencyconvertor({super.key});

  @override
  State<Currencyconvertor> createState() => _CurrencyconvertorState();
}

class _CurrencyconvertorState extends State<Currencyconvertor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}