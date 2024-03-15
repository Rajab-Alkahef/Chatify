import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/views/chat_screen.dart';
import 'package:chat_app_new/views/home_screen.dart';
import 'package:chat_app_new/views/register_screen.dart';
import 'package:chat_app_new/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? password;

  String? email;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      blur: 1,
      progressIndicator: const CircularProgressIndicator(
        strokeCap: StrokeCap.round,
        color: kPrimaryColor,
      ),
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding / 3, horizontal: kDefaultPadding / 2),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Image.asset(
                    MediaQuery.of(context).platformBrightness ==
                            Brightness.light
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
                  customTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  customTextField(
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          UserCredential credential = await signinUser();
                          isLoading = false;
                          setState(() {});
                          snackbar(context, 'Success');
                          Navigator.pushReplacementNamed(context, HomeScreen.id
                              // MaterialPageRoute(
                              //     builder: (context) => const HomeScreen()),
                              );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            isLoading = false;
                            setState(() {});
                            snackbar(context, 'User not found');
                            // print('The password provided is too weak.');
                          } else if (e.code == 'wrong-password') {
                            isLoading = false;
                            setState(() {});
                            snackbar(context, 'Wrong password');

                            // print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                          snackbar(context, 'Oops There was an error');
                        }
                      }
                    },
                    label: 'Log in',
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
        ),
      ),
    );
  }

  Future<UserCredential> signinUser() async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    return credential;
  }
}
