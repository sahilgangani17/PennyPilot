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
  String password = ''; // Hidden password placeholder

  // Fetch user details from the database based on the current Firebase email
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
    _fetchUserDetails(); // Fetch user data when the page initializes
  }

  // Custom card widget
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

  // Custom detail box widget
  Widget detailBox(String heading, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
        Text(content),
      ],
    );
  }

  // Show password change dialog
  void _showPasswordChangeDialog() {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Current Password field
                TextFormField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Current Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                // New Password field
                TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'New Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Hide keyboard when the save button is pressed
                  FocusScope.of(context).unfocus();

                  try {
                    // Get the current user
                    User? user = FirebaseAuth.instance.currentUser;

                    // Reauthenticate the user with the current password
                    await _reauthenticateUser(user!, currentPasswordController.text);

                    // Update the password with the new one
                    await user.updatePassword(newPasswordController.text);
                    await user.reload();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Password changed successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Close the dialog
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error changing password: $e"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Reauthenticate the user with the current password
  Future<void> _reauthenticateUser(User user, String currentPassword) async {
    try {
      // Create a credential using the current password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      // Reauthenticate with the current credential
      await user.reauthenticateWithCredential(credential);
      print("Reauthentication successful");
    } catch (e) {
      print("Error during reauthentication: $e");
      throw Exception("Reauthentication failed. Please check your current password.");
    }
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
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Display user profile image (replace with dynamic data if available)
                    Icon(
                      Icons.person,
                      size: 50,
                    ),
                    const SizedBox(width: 20),
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                          onPressed: _showPasswordChangeDialog, // Show password change dialog
                          child: Text('Change'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Sign out button
              FilledButton(
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
