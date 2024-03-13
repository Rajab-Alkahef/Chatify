import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/widgets/custom_button.dart';
import 'package:chat_app_new/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static String id = 'register_screen';
  String? email;
  String? password;
  String? username;
  String? confirmpassword;
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
                  // try {
                  //   final credential = await FirebaseAuth.instance
                  //       .createUserWithEmailAndPassword(
                  //     email: email!,
                  //     password: password!,
                  //   );

                  //   print('-------------');
                  //   print(credential.user!.displayName);
                  // } on FirebaseAuthException catch (e) {
                  //   if (e.code == 'weak-password') {
                  //     print('The password provided is too weak.');
                  //   } else if (e.code == 'email-already-in-use') {
                  //     print('The account already exists for that email.');
                  //   }
                  // } catch (e) {
                  //   print(e);
                  // }
                  // Assuming 'username', 'email', 'password', and 'confirmPassword' are already defined
                  if (password == confirmpassword) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email!,
                        password: password!,
                      );
                      print(username);

                      await credential.user?.updateDisplayName("Rajab");
                      await credential.user?.reload();
                      print('-------------');
                      var currentUser = FirebaseAuth.instance.currentUser;
                      print(currentUser?.displayName);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return Scaffold(
                      //         body: Column(
                      //           children: [
                      //             Text(credential.user!.displayName!),
                      //             Text(username!),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    print('The passwords do not match.');
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
    );
  }
}
