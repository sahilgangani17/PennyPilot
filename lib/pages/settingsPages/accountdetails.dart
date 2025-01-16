import 'package:flutter/material.dart';

class Accountdetails extends StatefulWidget {
  const Accountdetails({super.key});

  @override
  State<Accountdetails> createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Pic , Name and Email
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        //TODO: Image profile upload from local device
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                'https://wallpapers.com/images/hd/white-duck-face-close-up-ybtrbmo0scwowgn1.jpg',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
        
                      ),
                      SizedBox(height: 20,),
                      Text(
                        '(UserName)',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '(Email)',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            //Login Details
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    'Login Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          Text('(UserEmail)')
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('(UserPassword)'),
                              ElevatedButton(onPressed: (){}, child:Text('Change'))
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ) ,
            ),
            SizedBox(height: 20,),
            //Personal Details
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child:Column(
                children: [
                  Text(
                    'Personal Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10,),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            ),
                          Text('(UserPhoneNumber)'),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            ),
                          Text('(UserDOB)')//TODO date and time button
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            ),
                          Text('(UserAddress)')
                        ],
                      )
                    ],
                  )
                ],
              ) ,
            ),
            SizedBox(height: 20,),
            //Account Settings
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child:Column(
                  children: [
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Two factor Authentication'),
                            //TODO: Switch
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    )
                  ],
                )
            ),
            ElevatedButton(onPressed: () {}, child: Text('SIGN OUT'))
          ],
        ),
      ),
    );
  }
}
