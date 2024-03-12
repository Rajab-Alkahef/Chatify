import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static String id = 'register_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 3, horizontal: kDefaultPadding / 2),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? 'assets/icons/chat_app_logo_light-03.png'
                    : 'assets/icons/chat_app_logo_dark-03.png',
                // width: 100,
                height: MediaQuery.of(context).size.width / 2.5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Register',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const customTextField(
                hintText: 'Username',
              ),
              const customTextField(
                hintText: 'Email',
              ),
              const customTextField(
                hintText: 'Password',
              ),
              const customTextField(
                hintText: 'Confirm Password',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
