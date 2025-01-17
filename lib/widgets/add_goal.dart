import 'package:flutter/material.dart';
import 'package:penny_pilot/utils/icon_list.dart';

class AddGoal extends StatefulWidget {
  const AddGoal({super.key});

  @override
  State<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _goalNameController = TextEditingController();
  final _targetAmountController = TextEditingController();


  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime(DateTime.now().year + 100), 
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {

      String goalName = _goalNameController.text;
      double targetAmount = double.parse(_targetAmountController.text);

      print('Goal Name: $goalName');
      print('Target Amount: $targetAmount');
      print('Target Date: $_selectedDate');


      Navigator.of(context).pop(); 

    }
  }


  @override
  Widget build(BuildContext context) {
    return Form ( 
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              //Heading
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    'Add\nSaving Goal',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  )
                )
              ),

              // Goal Name Input
              TextFormField(
                controller: _goalNameController,
                decoration: const InputDecoration(
                  labelText: 'Goal Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) { 
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal name';
                  }
                  return null; 
                },
              ),
              const SizedBox(height: 16),
              
              // Target Amount Input
              TextFormField(
                controller: _targetAmountController, 
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Target Amount',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(AppIcons().getCurrencyIcon('Rupee')),
                ),
                validator: (value) { 
                  if (value == null || value.isEmpty) {
                    return 'Please enter a target amount';
                  }
                  try {
                    double.parse(value); // Check if it's a valid number
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null; // Return null if valid
                },
              ),
              const SizedBox(height: 16),
              
              /* const Text(
                'Target Date',
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 4,), */
              // Target Date
              InkWell(
                onTap: _presentDatePicker,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align text and icon
                    children: [
                      _selectedDate == null
                        ? Text(
                          'Select Target Date',
                          style: const TextStyle(color: Colors.black45),
                        )
                        : Text(
                          'Selected: ${_selectedDate.toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      const Icon(Icons.calendar_today), // Add a calendar icon
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              
              ElevatedButton(
                onPressed: _selectedDate == null ? null : _submitData, 
                child: const Text('Save Goal'),
              ),
              ElevatedButton(
                  onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Discard',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
        ),
      )
    );
  }
}
