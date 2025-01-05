import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny_pilot/pages/homepage.dart'; // Ensure this import is correct

class AuthService {
  // Function to create a new user
  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      
      // Navigate to HomePage and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,  // This will remove all previous routes
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // If email is already in use, show an error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign Up Failed"),
              content: Text("The account already exists for that email."),
            );
          },
        );
      } else {
        // For other errors, show a generic error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sign Up Failed"),
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
      
      // Navigate to HomePage and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,  // This will remove all previous routes
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text(e.message ?? 'An error occurred.'),
          );
        },
      );
    }
  }
}
