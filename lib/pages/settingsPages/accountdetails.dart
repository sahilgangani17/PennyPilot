import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:penny_pilot/pages/login.dart';

class Accountdetails extends StatefulWidget {
  const Accountdetails({super.key});

  @override
  State<Accountdetails> createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  String username = '';
  String email = '';
  String phoneno = '';
  String password = '';

  // Get the local file path
  Future<File> get _localFile async {
    final path = await getApplicationDocumentsDirectory();
    return File('$path/user_data.json');
  }

  // Fetch user data from the JSON file
  Future<void> _fetchData() async {
    try {
      final file = await _localFile;
      print("Reading from file: ${file.path}"); // Debugging print

      if (await file.exists()) {
        String data = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(data);

        setState(() {
          username = jsonData[0]['username'];
          email = jsonData[0]['email'];
          phoneno = jsonData[0]['phoneno'];
          password = jsonData[0]['password'];
        });

        print("Data fetched successfully: $jsonData");
      } else {
        print("File not found.");
      }
    } catch (e) {
      print("Error reading data from JSON: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the page is initialized
  }

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
      ),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display user details
              appCard(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Display user profile image (you can replace this with dynamic data)
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
                      username,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                )
              ),
              // Login Details
              appCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [  
                    Text(
                      'Login Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10,),
                    detailBox('Email', email),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        detailBox('Password', password),
                        ElevatedButton(
                          onPressed: () {
                            // Handle password change functionality
                          }, 
                          child: Text('Change')
                        )
                      ],
                    ),
                    detailBox('Phone', phoneno),
                  ]
                ),
              ),
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
      ),
    );
  }
}
