import 'package:flutter/material.dart';
class Helpsupport extends StatefulWidget {
  const Helpsupport({super.key});

  @override
  State<Helpsupport> createState() => _HelpsupportState();
}

class _HelpsupportState extends State<Helpsupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: Colors.grey[300],
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      child:Icon(Icons.lightbulb_circle_outlined),
                    ),
                    Column(
                      children: [
                        Text('How It Works?'),
                        Text('Get Started with Penny Pilot!')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
            child:Column(
              children: [
                Text('Track your Expenses'),
                Text('1. You can add Transcation by categorizing your expenses(salary, food, EMIs,stc)'),
                Text('2. Set your limited budgets for different categories'),
                Text('3. Convert your Currencies from INR to any other currency'),
                Text('4. Get detailed Analysed report for your Expeneses and incomes'),
                Text('5. Manage your saving and active goals accordingly ')
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            child: Column(
              children: [
                Text('Features Guide'),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.category),
                        Text('Categories: Organize your Expense according to types.'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.pie_chart),
                        Text('Analytics: Analyse and visual reports.')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.notifications),
                        Text('Get notified of Unusual Activities')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.savings),
                        Text('Set and track financial targets accordingly.')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Text('Need Help?'),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Contact Support'),
                        Text('We are here to help'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('FAQs'),
                        Text('Frequently asked Questions'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black12,
          ),
            child: Column(
              children: [
                Text('Tips and Trusted Practices'),
                Text('-> Regularly update your Transaction history'),
                Text('-> Review your Spending patterns monthly'),
                Text('-> Set realistic budgets goal'),
                Text('Enable notification for better tracking'),
                Text('Export report to tax purposes')
              ],
            ),
          )
        ],
      ),
    );
  }
}
