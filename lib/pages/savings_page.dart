import 'package:flutter/material.dart';
import 'package:penny_pilot/widgets/add_goal.dart';
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
      backgroundColor: const Color.fromARGB(100, 200, 213, 185),
  body: SingleChildScrollView(
    child: Column(
      
      children:[ 
        Container(
          color: Colors.blue[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue[800],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total Savings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 10,),
                  Text(
                    '₹12,450',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                      ),
                      // SizedBox(height: 5,),
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
          ],
        ),
      ),
      Container(
        
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          ),
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
                  ElevatedButton.icon(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context)=>AlertDialog(
                        content: AddGoal(),
                      ),
                      );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,// +
                    ),
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color.fromARGB(100, 131, 131, 131),
                      foregroundColor: Colors.white,
                      ),
                    label: Text(
                      'Add Goal',
                      )
                    ),       
              ],
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 200, 213, 185),
                borderRadius: BorderRadius.circular(20),
              ),
              //Progress Bar
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Example',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      Text(
                        '₹10,000',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ],
                  ),
                  Slider(
                    activeColor: Colors.green,
                    thumbColor: Colors.green,
                    inactiveColor: Color(0xFFE0E0E0),
                    min: 0.0,
                    max: 1,
                    value: 0.4,
                    onChanged: (newValue) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹20,000 Saved',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        ),
                        Text(
                          '40%',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                          ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              //Progress Bar
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 200, 213, 185),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Example',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      Text(
                        '₹10,000',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ],
                  ),
                  Slider(
                    activeColor: Colors.orange,
                    thumbColor: Colors.orange,
                    inactiveColor: Color(0xFFE0E0E0),
                    min: 0,
                    max: 1,
                    value: 0.25,
                    onChanged: (newValue) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹20,000 Saved',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        ),
                        Text(
                          '25%',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                          ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              //Progress Bar
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 200, 213, 185),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Example',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      Text(
                        '₹30,000',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                    ],
                  ),
                  Slider(
                    activeColor: Colors.blue,
                    thumbColor: Colors.blue,
                    inactiveColor: Color(0xFFE0E0E0),
                    min: 0,
                    max: 1,
                    value: 0.75,
                    onChanged: (newValue) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹70,000 Saved',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        ),
                        Text(
                          '75%',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          ),
                    ],
                  )
                ],
              ),
            ),
          ]
        ),
      ),
      ]
    ),
  ),
);

  }
}
