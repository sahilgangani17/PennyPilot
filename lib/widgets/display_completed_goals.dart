import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_saving.dart';
import 'package:penny_pilot/helper/helper_funcs.dart';
import 'package:penny_pilot/models/goal.dart';
import 'package:penny_pilot/widgets/completed_goal_tile.dart';

class DisplayGoals extends StatefulWidget {
  const DisplayGoals({super.key});
  
  @override
  State<DisplayGoals> createState() => _DisplayGoals();
}

class _DisplayGoals extends State<DisplayGoals> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Goal>>(
      future: DatabaseSaving.instance.fetchGoalHistory(getCurrentUserEmail()!),
      builder: (BuildContext context, AsyncSnapshot<List<Goal>> snapshot) {
        // Show loading message while data is being fetched
        if (!snapshot.hasData) {
          return Center(child: Text('Loading...'));
        }

        // Check if no data is available
        if (snapshot.data!.isEmpty) {
          return Center(child: Text('No Transactions made yet'));
        }

        // If data exists, display the list of transactions
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: snapshot.data!.map((goal) {
            return CompletedGoalTile(goal: goal); // Display each transaction
          }).toList(),
        );
      },
    );
  }
}
