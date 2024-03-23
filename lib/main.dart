import 'package:chat_app_new/firebase_options.dart';
import 'package:chat_app_new/views/chat_screen.dart';
import 'package:chat_app_new/views/home_screen.dart';
import 'package:chat_app_new/views/login_screen.dart';
import 'package:chat_app_new/views/onboarding_screen.dart';
import 'package:chat_app_new/views/register_screen.dart';
import 'package:chat_app_new/widgets/check_first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showLogin = prefs.getBool('showLogin') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    showLogin: showLogin,
  ));
}

class MyApp extends StatelessWidget {
  final bool showLogin;
  const MyApp({super.key, required this.showLogin});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.authStateChanges().listen(
    //   (User? user) {
    //     if (user != null) {
    //       print(user.uid);
    //     }
    //   },
    // );
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
      home: const CheckScreen(),
    );
  }

  // Widget initialRoute(BuildContext context) {
  //   if (showLogin) {
  //     return const onBoardingScreen();
  //   } else {
  //     Widget route = Container();
  //     FirebaseAuth.instance.authStateChanges().listen(
  //       (User? user) {
  //         if (user != null) {
  //           print(user.uid);
  //         } else {}
  //       },
  //     );
  //     // return route;
  //     return Container();
  //   }
  // }
}
