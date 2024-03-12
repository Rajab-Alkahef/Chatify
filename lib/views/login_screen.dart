import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/views/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset('assets/icons/chat_app_logo_sec_dark.png'),
          const TextField(),
          const TextField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, RegisterScreen.id),
                child: const Text(
                  "  Register",
                  style: TextStyle(color: kPrimaryColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
