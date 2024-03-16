import 'package:chat_app_new/components/snack_bar.dart';
import 'package:chat_app_new/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class floatingActionButton extends StatefulWidget {
  const floatingActionButton({
    super.key,
  });

  @override
  State<floatingActionButton> createState() => _floatingActionButtonState();
}

class _floatingActionButtonState extends State<floatingActionButton> {
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  // Future<void> _checkEmailExistence() async {
  //   final email = _contactEmailController.text;
  //   try {
  //     final signInMethods =
  //         // await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //         await FirebaseAuth.instance.;
  //     if (signInMethods.isEmpty) {
  //       // Email is not registered, proceed with adding the contact
  //       final contactName = _contactNameController.text;
  //       print('New contact added: $contactName');
  //       print('New contact email: $email');
  //       Navigator.pop(context); // Close the dialog
  //     } else {
  //       // Email is already registered
  //       print('Email $email is already registered.');
  //       // Show an error message or handle it as needed
  //     }
  //   } catch (e) {
  //     print('Error checking email existence: $e');
  //     // Handle any exceptions (e.g., network error)
  //   }
  // }
  Future<bool> checkIfUserExists(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

  void onSubmit() async {
    final contactEmail = _contactEmailController.text;
    final contactName = _contactNameController.text;
    bool userExistance = await checkIfUserExists(contactEmail);
    if (!userExistance) {
      snackbar(context, "The email does not exist");
    } else {
      snackbar(context, "Contact added");
      print('New contact added: $contactName');
      print('New contact added: $contactEmail');
      Navigator.pop(context); // Close the dialog
      _contactEmailController.clear();
      _contactNameController.clear();
    }
    print('New contact added: $contactName');
    print('New contact added: $contactEmail');
    // Navigator.pop(context); // Close the dialog
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Contact'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: _contactNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter contact name',
                  ),
                ),
                TextField(
                  onSubmitted: (value) {
                    onSubmit();
                  },
                  controller: _contactEmailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter contact email',
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _contactEmailController.clear();
                _contactNameController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: onSubmit,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
      // color: kPrimaryColor,
      width: 55.0,
      height: 55.0,
      child: RawMaterialButton(
        shape: const CircleBorder(),
        elevation: 0.0,
        child: const Icon(
          Icons.person_add_alt_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          _showAddContactDialog(context);
        },
      ),
    );
  }
}
