import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chatTextField extends StatefulWidget {
  chatTextField({
    this.message,
    super.key,
    required this.controller,
    required this.userEmail,
    required this.friendEmail,
    required this.friendId,
    required this.userId,
  });
  final ScrollController controller;
  CollectionReference? message;
  final String userEmail;
  final String friendEmail;
  final String friendId;
  final String userId;
  @override
  State<chatTextField> createState() => _chatTextFieldState();
}

class _chatTextFieldState extends State<chatTextField> {
  final TextEditingController _textController = TextEditingController();
  bool _showSendIcon = false;
  final chatService _chatservice = chatService();
  void sendmessage() async {
    if (_textController.text.isNotEmpty) {
      await _chatservice.sendmessage(
          widget.friendId, _textController.text, widget.friendEmail);
      _textController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _showSendIcon = _textController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String message = '';
    return Container(
      margin: const EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.insert_emoticon_sharp,
                        color: kPrimaryColor.withOpacity(0.8),
                      ),
                      onPressed: () {}),
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        // widget.message!.add(
                        //   {
                        //     kMessage: value,
                        //     kCreatedAt: DateTime.now(),
                        //     kUserId: widget.userEmail,
                        //   },
                        // );
                        // _textController.clear();
                        sendmessage();
                        widget.controller.animateTo(0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut);
                      },
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        _onTextChanged();
                      },
                      controller: _textController,
                      decoration: const InputDecoration(
                          hintText: "Type Something...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_rounded,
                        color: kPrimaryColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: kPrimaryColor),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
                color: kPrimaryColor, shape: BoxShape.circle),
            child: InkWell(
              child: Icon(
                _showSendIcon ? Icons.send : Icons.keyboard_voice,
                color: Colors.white,
              ),
              onLongPress: () {},
            ),
          )
        ],
      ),
    );
  }
}
