import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:penny_pilot/utils/icon_list.dart';

class AddNewTransaction extends StatefulWidget {
  const AddNewTransaction({super.key});

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  var type = 'Expenses';
  var category = "Others";

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Heading
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    'Add New Transaction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  )
                )
              ),

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
                  // // Add transaction logic here
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text(
                  //         'Transaction Added: Type: $type, Category: $category'),
                  //   ),
                  // );
                },
                child: const Text("Save"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Discard",style: TextStyle(color: Colors.red),),
              )
            ],
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
                //color: Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(
                e['name'],
                //style: const TextStyle(color: Colors.black45),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
