import 'package:chat_app_new/constants.dart';
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
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final contactEmail = _contactEmailController.text;
                final contactName = _contactNameController.text;
                print('New contact added: $contactName');
                print('New contact added: $contactEmail');
                Navigator.pop(context); // Close the dialog
              },
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
