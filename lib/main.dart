import 'package:chat_app_new/firebase_options.dart';
import 'package:chat_app_new/views/chat_screen.dart';
import 'package:chat_app_new/views/home_screen.dart';
import 'package:chat_app_new/views/login_screen.dart';
import 'package:chat_app_new/views/onboarding_screen.dart';
import 'package:chat_app_new/views/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        chatScreen.id: (context) => const chatScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
      },
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: onBoardingScreen.id,
    );
  }
}
