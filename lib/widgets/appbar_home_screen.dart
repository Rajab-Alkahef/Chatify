import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';

AppBar appBarhomeScreen(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text('Chats'),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
    ],
    backgroundColor:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? kPrimaryColor
            : const Color(0xff272244),
  );
}
