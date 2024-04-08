import 'dart:io';

import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/models/contacts.dart';
import 'package:chat_app_new/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  List<ContactsModel> contactsfriendList = [];
  final TextEditingController _textController = TextEditingController();
  bool _showSendIcon = false;
  File? _image;
  final chatService _chatservice = chatService();
  final contacts = FirebaseFirestore.instance.collection(kContacts);
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final uemail = FirebaseAuth.instance.currentUser!.email;
  final uname = FirebaseAuth.instance.currentUser!.displayName!;
  void sendmessage() async {
    if (_textController.text.isNotEmpty) {
      getUserContacts();
      addContact(uname, uemail!, uid);
      await _chatservice.sendmessage(
          widget.friendId, _textController.text, widget.friendEmail);
      // _textController.clear();
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
          GestureDetector(
            onTap: () {
              if (_showSendIcon) {
                sendmessage();
                widget.controller.animateTo(0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut);
                _textController.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: Icon(
                _showSendIcon ? Icons.send : Icons.keyboard_voice,
                color: Colors.white,
              ),
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

  void addContact(String names, String emails, String userId) {
    final existingContact =
        contactsfriendList.cast<ContactsModel?>().firstWhere(
              (contact) => contact?.email == emails,
              orElse: () => null,
            );

    if (existingContact != null) {
      // snackbar(context, "Contact already exists");
      print('Contact already exists');
    } else {
      final newContact =
          ContactsModel(name: uname, email: uemail, contactId: uid);
      int id = 0;
      setState(() {
        contactsfriendList.add(newContact);
        id = contactsfriendList.indexOf(newContact);
        contacts.add({
          // "contacting Id": id,
          // 'user email': uemail,
          // 'user id': uid,
          // 'contact email': emails,
          // 'contact name': names,
          // 'contact id': userId,
          "contacting Id": id,
          'user email': widget.friendEmail,
          'user id': widget.friendId,
          'contact email': uemail,
          'contact name': uname,
          'contact id': uid,
        });
      });
      // snackbar(context, "Contact added");
      print('Contact added');
      // print('New contact added: $contactName');
      // print('New contact added: $contactEmail'); // print("contact List is: ${contactsList[]}");
    }
  }

  Future<void> getUserContacts() async {
    final user = FirebaseAuth.instance.currentUser;

    // final userEmail = user!.email;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Contacts')
        .where('user email', isEqualTo: widget.friendEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        final document = querySnapshot.docs.elementAt(i);
        final contactName = document['contact name'];
        final contactEmail = document['contact email'];
        final contactId = document['contact id'];
        final Contact = ContactsModel(
            name: contactName, email: contactEmail, contactId: contactId);
        contactsfriendList.add(Contact);
        setState(() {});
        // Retrieve other fields as needed

        print('Contact Name: $contactName');
        print('Contact Email: $contactEmail');

        // setState(() {
        //   isLoading = false;
        // });
      }
      // Print other fields
    } else {
      print('No matching document found.');
    }
  }
}
