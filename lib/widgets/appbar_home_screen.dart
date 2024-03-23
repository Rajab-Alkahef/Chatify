import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

AppBar appBarhomeScreen(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text('Chats'),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
      IconButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        },
        icon: const Icon(Icons.logout_rounded),
      ),
    ],
    backgroundColor:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? kPrimaryColor
            : const Color(0xff272244),
  );
}
