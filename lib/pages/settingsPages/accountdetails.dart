import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny_pilot/pages/login.dart';

class Accountdetails extends StatefulWidget {
  const Accountdetails({super.key});

  @override
  State<Accountdetails> createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  
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

  Widget detailBox(String heading, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            Text(content)
          ],
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
        //backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            
            // User Dashboard
              appCard(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //TODO: Image profile upload from local device
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://wallpapers.com/images/hd/white-duck-face-close-up-ybtrbmo0scwowgn1.jpg',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Text(
                      '(UserName)',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                )
              ),
            
            //Login Details
              appCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [  
                    // Heading
                    Text(
                      'Login Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10,),
                    // Email
                    detailBox('Email', '{UserEmail}'),
                    const SizedBox(height: 10),
                    // Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        detailBox('Password', '{UserPassword}'),
                        ElevatedButton(
                          onPressed: () {

                          }, 
                          child: Text('Change')
                        )
                      ],
                    ),
                    // Phone
                    detailBox('Phone', '{UserPhone}'),
                  ]
                ),
              ),
            
            
            /* //Account Settings
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
             */
            ElevatedButton(
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }, 
              child: Text('SIGN OUT')
              )
          ],
        ),
      ),
    )
    );
  }
}
