import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny_pilot/database/db_user.dart';
import 'package:penny_pilot/helper/helper_funcs.dart';
import 'package:penny_pilot/pages/login.dart';

class Accountdetails extends StatefulWidget {
  const Accountdetails({super.key});

  @override
  State<Accountdetails> createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  //String username = '';
  String email = '';
  String phoneno = '';
  String password = ''; // Hide password for security reasons

  // Fetch user details from the database based on current Firebase email
  Future<void> _fetchUserDetails() async {
    // Get current user's email from Firebase Authentication

    // Check if the user is logged in
    if (getCurrentUserEmail() == null) {
      print("No user is currently logged in.");
      // Redirect to Login if no user is logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      return;
    }

    // Fetch user data from the database based on the email
    //var users = await DatabaseUser.instance.fetchAllUsers();
    var userEmail = getCurrentUserEmail();

    if (userEmail!.isNotEmpty) {
      setState(() {
        email = userEmail;
        //username = users.firstWhere((user) => user.email == userEmail).;
        //phoneno = users.;
        password = "********"; // Do not display the actual password
      });
    } /* else {
      print("No user found with email: $widget.currentUserEmail");
      // Handle case when there are no users found with the provided email
    } */
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails(); // Fetch user data when the page is initialized
  }

  Widget appCard(Widget? child) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  Widget detailBox(String heading, String content) {
    return Column(
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
        Text(content),
      ],
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
              // Display user profile image and username
              appCard(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Display user profile image (replace with dynamic data if available)
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
                      email,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Display login details
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
                    const SizedBox(height: 10),
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
                          child: Text('Change'),
                        ),
                      ],
                    ),
                    detailBox('Phone', phoneno),
                  ],
                ),
              ),
              // Sign out button
              ElevatedButton(
                onPressed: () async {
                  // Sign out the user from Firebase
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text('SIGN OUT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
