import 'package:chat_app_new/components/snack_bar.dart';
import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/models/contacts.dart';
import 'package:chat_app_new/views/chat_screen.dart';
import 'package:chat_app_new/widgets/appbar_home_screen.dart';
import 'package:chat_app_new/widgets/contact_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final contacts = FirebaseFirestore.instance.collection(kContacts);
  List<ContactsModel> contactsList = [];

  @override
  Widget build(BuildContext context) {
    var userEmail = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      floatingActionButton: Container(
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
      ),
      // floatingActionButton(contactsList: contactsList  ),
      appBar: appBarhomeScreen(context),
      body: SafeArea(
        child: ListView.builder(
          itemCount: contactsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, chatScreen.id,
                        arguments: [userEmail, contactsList[index].email]);
                  },
                  child: const contactCard()),
            );
          },
        ),
      ),
    );
  }

  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  void addContact(String names, String emails) {
    final existingContact = contactsList.cast<ContactsModel?>().firstWhere(
          (contact) => contact?.email == emails,
          orElse: () => null,
        );

    if (existingContact != null) {
      snackbar(context, "Contact already exists");
      print('Contact already exists');
    } else {
      final newContact = ContactsModel(name: names, email: emails);
      int id = 0;
      setState(() {
        contactsList.add(newContact);
        id = contactsList.indexOf(newContact);
        contacts.add({
          "contact Id": id,
          'user email': ModalRoute.of(context)!.settings.arguments as String,
          'contact email': emails,
          'user name': names
        });
      });
      snackbar(context, "Contact added");
      // print('New contact added: $contactName');
      // print('New contact added: $contactEmail'); // print("contact List is: ${contactsList[]}");
    }
  }

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
      addContact(contactName, contactEmail);

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
}
