import 'package:flutter/material.dart';
import 'package:penny_pilot/utils/appvalidate.dart';
import 'package:penny_pilot/utils/icon_list.dart';

class AddNewTransaction extends StatefulWidget {
  const AddNewTransaction({super.key});

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  var type = 'Expenses';
  var category = "Others";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var isLoader = false;
  var appvalidate = Appvalidate();

  Future<void> _submitForm() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      // Simulate a network request or data processing
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Heading
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Text(
                      'Add New Transaction',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
      
                // Title Input
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: appvalidate.isEmptyCheck,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
      
                // Type Dropdown
                DropdownButtonFormField<String>(
                  value: type,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      child: Text('Expenses'),
                      value: 'Expenses',
                    ),
                    DropdownMenuItem(
                      child: Text('Income'),
                      value: 'Income',
                    ),
                    DropdownMenuItem(
                      child : Text("Savings"),
                      value: 'Savings',
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        type = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
      
                // Amount Input
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: appvalidate.isEmptyCheck,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee_sharp),
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
      
                // Category Dropdown
                CategoryDropdown(
                  cattype: category,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        category = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
      
                // Description Input
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
      
                // Add Transaction Button
                ElevatedButton(
                  onPressed: () {
                    if (!isLoader) {
                      _submitForm();
                    }
                  },
                  child: isLoader
                      ? const Center(child: CircularProgressIndicator())
                      : const Text("Add Transaction"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Discard",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.cattype,
    required this.onChanged,
  });

  final String? cattype;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final appicon = AppIcons();
    return DropdownButtonFormField<String>(
      value: cattype,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: "Category",
        border: OutlineInputBorder(),
      ),
      items: appicon.homeExpenseCategories.map((e) {
        return DropdownMenuItem<String>(
          value: e['name'],
          child: Row(
            children: [
              Icon(
                e['icon'] as IconData, // Type casting for safety
              ),
              const SizedBox(width: 8),
              Text(e['name']),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
