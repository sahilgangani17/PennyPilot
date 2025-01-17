import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_saving.dart';
import 'package:penny_pilot/helper/helper_funcs.dart';
import 'package:penny_pilot/widgets/display_completed_goals.dart';

class GoalTxnPage extends StatefulWidget {
  const GoalTxnPage({super.key});

  @override
  State<GoalTxnPage> createState() => _GoalTxnPageState();
}

class _GoalTxnPageState extends State<GoalTxnPage> {
  
  // Fetching the category-wise Goal from the database
  Future<Map<String, double>> fetchData() async {
    final dbService = DatabaseSaving.instance;
    var result = await dbService.fetchGoalHistory(getCurrentUserEmail()!); // Adjust this to fetch Goal data

  Map<String, double> categoryData = {};
    for (var row in result) {
     
      // Ensure that title is a String and total amount is a double
      String title = row.title as String? ?? ''; // Handle null categories if necessary
      double totalAmount = row.target_amount as double? ?? 0.0; // Handle null amount

      // Add the title and total expense to the map
      categoryData[title] = totalAmount;
    }
    return categoryData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading state
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error handling
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.')); // No data found
        } else {
            return DisplayGoals();// Show the transaction list for Goal
        }
      },
    );
  }

  
}
