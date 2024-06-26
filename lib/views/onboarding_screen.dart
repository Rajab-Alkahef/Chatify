import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({
    super.key,
  });
  static String id = 'onboarding';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/images/onboarding-01 (Medium).png'),
            const Spacer(),
            Text(
              textAlign: TextAlign.center,
              'Welcome to Chatify\nmessaging app',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              textAlign: TextAlign.center,
              'Chat with any body\nin this world',
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500)
                    .color
                    ?.withOpacity(0.64),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: TextButton(
                onPressed: () {
                  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  //   if (user != null) {
                  //     print(user.uid);
                  //     print(user.email);
                  //   }
                  // });
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Skip',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.color
                                ?.withOpacity(0.8),
                          ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.color
                          ?.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
