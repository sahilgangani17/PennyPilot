import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Currencyconvertor extends StatefulWidget {
  const Currencyconvertor({super.key});

  @override
  State<Currencyconvertor> createState() => _CurrencyconvertorState();
}

class _CurrencyconvertorState extends State<Currencyconvertor> {
  String initial_dropdownvalue1 = 'INR(₹)';
  String initial_dropdownvalue2 = 'US Dollar(\$)';
  int? result;

  final Map<String, Map<String, double>> _exchangeRates = {
    'INR(₹)': {
      'US Dollar(\$)': 0.012,
      'Euro(€)': 0.011,
      'Pounds(£)': 0.0098,
      'Yen(¥)': 1.7,
      'INR(₹)': 1.0,
    },
    'US Dollar(\$)': {
      'INR(₹)': 82.0,
      'Euro(€)': 0.91,
      'Pounds(£)': 0.82,
      'Yen(¥)': 140.0,
      'US Dollar(\$)': 1.0,
    },
    'Euro(€)': {
      'INR(₹)': 88.92,
      'Euro(€)': 1.0,
      'Pounds(£)': 0.84,
      'Yen(¥)': 161.08,
      'US Dollar(\$)': 1.03,
    },
    'Pounds(£)': {
      'INR(₹)': 105.69,
      'Euro(€)': 1.19,
      'Pounds(£)': 1.0,
      'Yen(¥)': 191.37,
      'US Dollar(\$)': 1.22,
    },
    'Yen(¥)': {
      'INR(₹)': 0.55,
      'Euro(€)': 0.0062,
      'Pounds(£)': 0.0052,
      'Yen(¥)': 1.0,
      'US Dollar(\$)': 0.0064,
    },
  };

  double _amount = 0.0;
  String _result = '0.0';

  @override
  Widget build(BuildContext context) {
    Widget dropDownVariablefrom = DropdownButton<String>(
      value: initial_dropdownvalue1,
      onChanged: (String? newValue) {
        setState(() {
          initial_dropdownvalue1 = newValue!;
        });
      },
      items: <String>[
        'INR(₹)',
        'Euro(€)',
        'US Dollar(\$)',
        'Pounds(£)',
        'Yen(¥)',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    Widget dropDownVariableTo = DropdownButton<String>(
      value: initial_dropdownvalue2,
      onChanged: (String? newValue) {
        setState(() {
          initial_dropdownvalue2 = newValue!;
        });
      },
      items: <String>[
        'US Dollar(\$)',
        'Euro(€)',
        'INR(₹)',
        'Pounds(£)',
        'Yen(¥)',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Currency Converter"),
          backgroundColor: Colors.grey[300],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _amount = double.tryParse(value) ?? 0.0;
                              });
                            },
                            decoration: InputDecoration(
                              label: Text('Enter Amount'),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                'From',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                              dropDownVariablefrom,
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                String temp = initial_dropdownvalue1;
                                initial_dropdownvalue1 = initial_dropdownvalue2;
                                initial_dropdownvalue2 = temp;
                              });
                            },
                            icon: Icon(Icons.swap_vert),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                'To',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                              dropDownVariableTo,
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (_exchangeRates
                                        .containsKey(initial_dropdownvalue1) &&
                                    _exchangeRates[initial_dropdownvalue1]!
                                        .containsKey(initial_dropdownvalue2)) {
                                  final double rate =
                                      _exchangeRates[initial_dropdownvalue1]![
                                          initial_dropdownvalue2]!;
                                  _result = (_amount * rate).toStringAsFixed(2);
                                } else {
                                  _result = 'Rate not found';
                                  print(
                                      'Error: Rate not found for $initial_dropdownvalue1 to $initial_dropdownvalue2');
                                }
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.grey[200]),
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.black),
                            ),
                            child: Text('Convert'),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_result),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          //Copy to clip Board Logic
                                          Clipboard.setData(
                                              ClipboardData(text: _result));
                                          // Optionally, show a Snackbar to confirm the copy operation
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Result copied to clipboard')),
                                          );
                                        },
                                        icon: Icon(Icons.copy)),
                                    IconButton(
                                        onPressed: () {
                                          //Logic to add amoount in transaction
                                        },
                                        icon: Icon(Icons.add)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
