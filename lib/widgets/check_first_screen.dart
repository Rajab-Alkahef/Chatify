import 'package:chat_app_new/views/home_screen.dart';
import 'package:chat_app_new/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state (optional)
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // User is logged in
          final user = snapshot.data!;
          print('User ID: ${user.uid}');
          // Return your home screen widget here
          return const HomeScreen();
        } else {
          // User is not logged in
          // Return your login screen widget here
          return const LoginScreen();
        }
      },
    );
  }
}
