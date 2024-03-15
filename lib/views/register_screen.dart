import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/views/chat_screen.dart';
import 'package:chat_app_new/views/home_screen.dart';
import 'package:chat_app_new/widgets/custom_button.dart';
import 'package:chat_app_new/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  String? username;

  String? confirmpassword;

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
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  customTextField(
                    onChanged: (data) {
                      username = data;
                    },
                    hintText: 'Username',
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
                  customTextField(
                    onChanged: (data) {
                      confirmpassword = data;
                    },
                    hintText: 'Confirm Password',
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        if (password == confirmpassword) {
                          isLoading = true;
                          setState(() {});
                          try {
                            UserCredential credential = await registerUser();
                            print(username);
                            isLoading = false;
                            setState(() {});
                            snackbar(context, 'Success');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                            await updateUsername(credential, username!);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              isLoading = false;
                              setState(() {});
                              snackbar(
                                  context, 'The password provided is too weak');
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              isLoading = false;
                              setState(() {});
                              snackbar(context,
                                  'The account already exists for that email');

                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                            snackbar(context, 'Oops There was an error');
                          }
                        } else {
                          snackbar(context, "The passwords doesn't match");

                          print("The passwords doesn't match");
                        }
                      }
                    },
                    color: kSecondaryColor,
                    label: 'Register',
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
        ),
      ),
    );
  }

  Future<void> updateUsername(UserCredential credential, String name) async {
    await credential.user?.updateDisplayName(name);
    await credential.user?.reload();
    var currentUser = FirebaseAuth.instance.currentUser;
    print('-------------');
    // Now this should print the updated username
    print(currentUser?.displayName);
  }

  Future<UserCredential> registerUser() async {
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return credential;
  }
}
