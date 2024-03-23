import 'dart:io';

import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _image;
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
                    onPressed: () async {
                      _pickImageFromCamera();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: kPrimaryColor),
                    onPressed: () {
                      _pickImageFromGallery();
                    },
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
              onTap: () {
                if (_showSendIcon) {
                  sendmessage();
                  widget.controller.animateTo(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut);
                }
              },
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

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMedia();
    if (returnedImage == null) return;
    setState(() {
      _image = File(returnedImage.path);
    });
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          child: _image != null
              ? Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        height: 400,
                        width: 400,
                        // child: Image.file(_image!),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 50),
                              foregroundColor: Colors.white,
                              backgroundColor: kPrimaryColor,
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.check),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              : Container(
                  child: const Text('please select an image'),
                ),
        );
      },
    );
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _image = File(returnedImage.path);
    });
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          child: _image != null
              ? Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        height: 400,
                        width: 400,
                        // child: Image.file(_image!),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 50),
                              foregroundColor: Colors.white,
                              backgroundColor: kPrimaryColor,
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.check),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              : Container(
                  child: const Text('please select an image'),
                ),
        );
      },
    );
  }
}
