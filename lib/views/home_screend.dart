import 'package:chat_app_new/widgets/chat_bubble.dart';
import 'package:chat_app_new/widgets/chat_text_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // itemCount: 5,
              itemBuilder: (context, index) {
                return const chatBubble();
              },
            ),
          ),
          const chatTextField(),
        ],
      ),
    );
  }
}
