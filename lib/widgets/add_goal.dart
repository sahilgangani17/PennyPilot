import 'package:flutter/material.dart';

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
      // initialDate: DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime(2050), 
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
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form( // Wrap with a Form widget
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Saving Goal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CloseButton(
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: _goalNameController, 
              decoration: const InputDecoration(
                labelText: 'Goal Name',
                filled: true,
                fillColor: Color.fromARGB(100, 200, 213, 185),
                border: OutlineInputBorder(),
              ),
              validator: (value) { 
                if (value == null || value.isEmpty) {
                  return 'Please enter a goal name';
                }
                return null; 
              },
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: _targetAmountController, 
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target Amount (₹)',
                filled: true,
                fillColor: Color.fromARGB(100, 200, 213, 185),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee_sharp),
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

            const SizedBox(height: 15),

            const Text(
              'Target Date',
              textAlign: TextAlign.left,
            ),
            InkWell(
              onTap: _presentDatePicker,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 200, 213, 185),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align text and icon
                  children: [
                  Text(
                      _selectedDate == null
                        ? 'Select Target Date'
                        : 'Selected: ${_selectedDate.toString().split(' ')[0]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
