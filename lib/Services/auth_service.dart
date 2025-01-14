import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny_pilot/pages/home_page.dart';
import 'package:penny_pilot/pages/login.dart';

class AuthService {
  // Function to create a new user
  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );

      // Show a success dialog before navigating to Login
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Account Created"),
            content: const Text("Your account has been created successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false, // Remove all previous routes
                  );
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // If email is already in use, show an error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Sign Up Failed"),
              content: const Text("The account already exists for that email."),
            );
          },
        );
      } else {
        // For other errors, show a generic error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Sign Up Failed"),
              content: Text(e.message ?? 'An error occurred.'),
            );
          },
        );
      }
    }
  }

  // Function to log in the user
  login(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
        (route) => false, 
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Login Error"),
            content: Text(e.message ?? 'An error occurred.'),
          );
        },
      );
    }
  }
}
