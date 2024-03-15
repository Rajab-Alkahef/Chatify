import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/widgets/appbar_home_screen.dart';
import 'package:chat_app_new/widgets/floating_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final messageCollection = FirebaseFirestore.instance.collection(kUsers);
    return Scaffold(
      floatingActionButton: const floatingActionButton(),
      appBar: appBarhomeScreen(context),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const Text('data');
        },
      ),
    );
  }
}
