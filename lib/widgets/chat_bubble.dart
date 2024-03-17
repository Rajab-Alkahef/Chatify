import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/models/chat_message.dart';
import 'package:flutter/material.dart';

class chatBubble extends StatelessWidget {
  const chatBubble({
    required this.message,
    super.key,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message.message,
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}
