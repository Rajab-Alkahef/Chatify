import 'dart:developer';

import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/models/chat_message.dart';
import 'package:chat_app_new/theme.dart';
import 'package:chat_app_new/widgets/appbar_chat_screen.dart';
import 'package:chat_app_new/widgets/chat_bubble.dart';
import 'package:chat_app_new/widgets/chat_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({super.key});
  static String id = 'chat-screen';
  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  final messageCollection =
      FirebaseFirestore.instance.collection(kMessageCollection);
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var userEmail = ModalRoute.of(context)!.settings.arguments as String;
    log(userEmail);
    return StreamBuilder<QuerySnapshot>(
        stream:
            messageCollection.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data!.docs[0][kMessage]);
            List<MessageModel> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBarChatScreen(context),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      reverse: true,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return chatBubble(
                          message: messageList[index],
                        );
                      },
                    ),
                  ),
                  chatTextField(
                    message: messageCollection,
                    controller: controller,
                    userEmail: userEmail,
                  ),
                ],
              ),
            );
          } else {
            return const Text('Loading...');
          }
        });
  }
}
