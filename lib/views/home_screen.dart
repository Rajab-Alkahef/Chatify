import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/widgets/appbar_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'home-screen';
  @override
  Widget build(BuildContext context) {
    final messageCollection = FirebaseFirestore.instance.collection(kUsers);
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person_add_alt_rounded),
      ),
      appBar: appBarhomeScreen(context),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const Text('data');
        },
      ),
    );
  }
}
