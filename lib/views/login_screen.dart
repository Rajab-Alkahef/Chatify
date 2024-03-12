import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/views/register_screen.dart';
import 'package:chat_app_new/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';
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
                height: MediaQuery.of(context).size.height / 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const customTextField(
                hintText: 'Email',
              ),
              const customTextField(
                hintText: 'Password',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RegisterScreen.id),
                    child: const Text(
                      "  Register",
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
