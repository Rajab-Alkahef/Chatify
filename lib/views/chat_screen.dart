import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/services/chat_services.dart';
import 'package:chat_app_new/widgets/appbar_chat_screen.dart';
import 'package:chat_app_new/widgets/chat_bubble.dart';
import 'package:chat_app_new/widgets/chat_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  // The constructor initializes the chatScreen widget with a unique key.
  const chatScreen({super.key});

  // The id is a static string that serves as a unique identifier for the chat screen.
  static String id = 'chat-screen';

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  // messageCollection is a final variable that holds a reference to the 'messagesCollection'
  // collection in Firebase Firestore.
  final messageCollection =
      FirebaseFirestore.instance.collection(kMessageCollection);

  // controller is a final variable that holds a ScrollController instance, which is used
  // to control the scroll position of a ListView.
  final controller = ScrollController();
  final chatService _chatService = chatService();

  @override
  Widget build(BuildContext context) {
    // Retrieve the list of emails from the arguments passed to the chatScreen widget.
    List data = ModalRoute.of(context)!.settings.arguments as List;

    // Extract the userEmail, friendEmail, and friendId from the list of emails.
    String userEmail = data[0].toString();
    String friendEmail = data[1].toString();
    String friendId = data[2].toString();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String friendName = data[3].toString();

    // The StreamBuilder widget listens to the stream of messages from the Firebase Firestore
    // collection and builds the UI based on the received data.
    return StreamBuilder(
        // The stream is a reference to the 'messagesCollection' collection in Firebase Firestore,
        // ordered by the 'created_at' field in descending order.
        stream: _chatService.getmessages(userId, friendId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // messageList is a list of MessageModel instances that are created from the
            // received data.
            // List<MessageModel> messageList = [];
            // for (int i = 0; i < snapshot.data!.docs.length; i++) {
            //   messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            // }

            return Scaffold(
              // The AppBarChatScreen widget is a custom app bar that displays the friend's
              // name and the back button.
              appBar: AppBarChatScreen(context, friendName),
              body: Column(
                children: [
                  // The Expanded widget is a widget that expands its child to fill the available
                  // space in the main axis (vertical axis in this case).
                  Expanded(
                    child: ListView(
                      // The controller is used to control the scroll position of the ListView.
                      controller: controller,
                      // The reverse property is set to true to display the messages in reverse
                      // chronological order.
                      reverse: true,
                      // The itemCount is the number of items in the messageList.

                      // The itemBuilder is a callback function that builds each item in the ListView.
                      children: snapshot.data!.docs
                          .map((document) => chatBubble(document))
                          .toList(),
                    ),
                  ),
                  chatTextField(
                    message: messageCollection,
                    controller: controller,
                    userEmail: userEmail,
                    friendEmail: friendEmail,
                    friendId: friendId,
                    userId: userId,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('There is an error');
          } else {
            return Scaffold(
              appBar: AppBarChatScreen(context, friendName),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
