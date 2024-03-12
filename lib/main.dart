import 'package:chat_app_new/views/login_screen.dart';
import 'package:chat_app_new/views/onboarding_screen.dart';
import 'package:chat_app_new/views/register_screen.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        onBoardingScreen.id: (context) => const onBoardingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
      },
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: onBoardingScreen.id,
    );
  }
}
