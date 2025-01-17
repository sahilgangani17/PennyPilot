import 'package:flutter/material.dart';
Widget appCard(Widget? child) {
  return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
          padding: EdgeInsets.all(20),
          child: child
      )
  );
}

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
      body:Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child:
          Column(
            children: [
              Container(
                child: appCard(
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0x4D9489F5),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Column(
                          children: [
                            Text('How It Works?',textAlign:TextAlign.center,style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),),
                            Text('Get Started with Penny Pilot!',textAlign:TextAlign.center , style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),)
                          ],
                        )
                      ],
                    )
                  ],
                ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  //color: Color(0x4D9489F5),
                  borderRadius: BorderRadius.circular(40),
                ),
                child:appCard(
                  Column(
                    children: [
                      Text('Track your Expenses',textAlign: TextAlign.center,style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),),
                      Text ('''
                      \n1. You can add Transaction by categorizing your expenses(salary, food, EMIs, etc)
                      \n2. Set your limited budgets for different categories
                      \n3. Convert your Currencies from INR to any other currency
                      \n4. Get detailed Analysed report for your Expenses and Incomes
                      \n5. Manage your saving and active goals accordingly
                      ''',
                      textAlign: TextAlign.left,
                      ),
                    ]
                  )
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                  //color: Color(0x4D9489F5),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: appCard(
                Column(
                  children: [
                    Text('Features Guide',style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),),
                    Column(
                      children: [
                        SizedBox(height: 25,),
                        Row(
                          children: [
                            Icon(Icons.category,size: 23,),
                            Text('Categories:Organize your Expense.',textAlign: TextAlign.left,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.pie_chart,size: 23,),
                            Text('Analytics: Analyse visual reports.')
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.notifications,size: 23,),
                            Text('Get notified of Unusual Activities')
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.savings,size: 23,),
                            Text('Set and track financial targets.')
                          ],
                        )
                      ],
                    )
                  ],
                ),
                ),
              ),
              SizedBox(height: 20,),
              // Container(
              //   decoration: BoxDecoration(
              //     //color: Color(0x4D9489F5),
              //     borderRadius: BorderRadius.circular(40),
              //   ),
              //   child: appCard(
              //   Column(
              //     children: [
              //       Text('Need Help?',textAlign: TextAlign.center,style: TextStyle(
              //         fontSize:25,
              //         fontWeight: FontWeight.w700,
              //       ),),
              //       Row(
              //         children: [
              //           Column(
              //             children: [
              //               Text('Contact Support',textAlign: TextAlign.left,),
              //               Text('We are here to help',textAlign: TextAlign.left),
              //               //Icon(Icons.arrow_forward_ios)
              //             ],
              //           )
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Column(
              //             children: [
              //               Text('FAQs'),
              //               Text('Frequently asked Questions'),
              //               //Icon(Icons.arrow_forward_ios)
              //             ],
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              //   ),
              // ),
              //SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  //color: Color(0x4D9489F5),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: appCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tips and Trusted Practices',textAlign: TextAlign.center,style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),),
                    Text('''
                    \n1. Regularly update your Transaction history
                    \n2. Review your Spending patterns monthly
                    \n3. Set realistic budgets goal
                    \n4. Enable notification for better tracking
                    \n5. Export report to tax purposes
                    ''',
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
