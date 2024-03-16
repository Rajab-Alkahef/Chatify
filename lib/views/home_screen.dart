import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/views/chat_screen.dart';
import 'package:chat_app_new/widgets/appbar_home_screen.dart';
import 'package:chat_app_new/widgets/contact_card.dart';
import 'package:chat_app_new/widgets/floating_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var userEmail = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      floatingActionButton: const floatingActionButton(),
      appBar: appBarhomeScreen(context),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, chatScreen.id,
                      arguments: userEmail);
                },
                child: const contactCard()),
          );
        },
      ),
    );
  }
}
