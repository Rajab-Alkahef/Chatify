import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static String id = 'register_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset('assets/icons/chat_app_logo_sec_dark.png'),
          const customTextField(
            hintText: 'Email',
          ),
          const customTextField(
            hintText: 'Password',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "  Log in",
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

class customTextField extends StatelessWidget {
  const customTextField({
    super.key,
    required this.hintText,
  });
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: TextField(
        decoration: InputDecoration(
          labelText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
