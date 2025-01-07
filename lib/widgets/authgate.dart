import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penny_pilot/pages/all_pages.dart';
import 'package:penny_pilot/pages/login.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if the user is logged in
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Show loading indicator
        }

        if (snapshot.hasData) {
          // If user is logged in, go to HomePage
          return const HomePage();
        } else {
          // If user is not logged in, go to Login page
          return Login();
        }
      },
    );
  }
}
