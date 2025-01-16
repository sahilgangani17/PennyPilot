import 'package:flutter/material.dart';
import 'package:penny_pilot/widgets/add_goal.dart';
import 'package:penny_pilot/widgets/goal_tile.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: -- Remaining Logic build up and  backend --For Sankalp Dawada
class SavingGoals extends StatefulWidget {
  const SavingGoals({super.key});

  @override
  State<SavingGoals> createState() => _SavingGoalsState();
}

class _SavingGoalsState extends State<SavingGoals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
        children:[ 
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blue[800],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total Savings',
                  style: TextStyle (
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                
                Text(
                  '₹12,450',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                
                Text(
                  '+₹2,450 this month',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ]
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(16),
              /* decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ), */
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active Goals',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context)=> AlertDialog(
                              content: AddGoal(),
                            ),
                          );
                        },
                        icon: Icon(Icons.add),
                        /* style: ElevatedButton.styleFrom(
                          //backgroundColor:Color.fromARGB(100, 131, 131, 131),
                          foregroundColor: Colors.white,
                        ), */
                        label: Text('Add Goal')
                      ),       
                    ],
                  ),
                  SizedBox(height: 10,),
                  
                  GoalTile(goal: 'Gaming Laptop', progressColor: Colors.green),  
                  GoalTile(goal: 'Dream Car', progressColor: Colors.pink),
                  GoalTile(goal: 'Dream House', progressColor: Colors.blue),
                ],
              ),
            ),
      ) 
      ]
        ),
      )
      );

  }
}
