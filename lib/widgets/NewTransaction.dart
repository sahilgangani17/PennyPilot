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
  var category = "others";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var isLoader = false;
  var appvalidate = Appvalidate();

  Future<void> _submitForm() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      // var data = {
      //   "email": _emailController.text,
      //   "password": _passwordController.text,
      // };
      // await authService.login(data, context);
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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

              // Amount Input
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: appvalidate.isEmptyCheck,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
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

              // Add Transaction Button
              ElevatedButton(
                onPressed: () {
                  if (isLoader == false){
                  _submitForm();
                  }
                },
                child: 
                isLoader ? Center(child: CircularProgressIndicator()):
                const Text("Add Transaction"),
              ),
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
                color: Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(
                e['name'],
                style: const TextStyle(color: Colors.black45),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
