import 'package:chat_app_new/components/snack_bar.dart';
import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/models/contacts.dart';
import 'package:chat_app_new/views/chat_screen.dart';
import 'package:chat_app_new/widgets/appbar_home_screen.dart';
import 'package:chat_app_new/widgets/contact_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final uemail = FirebaseAuth.instance.currentUser!.email;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getUserContacts();
  }

  @override
  Widget build(BuildContext context) {
    // log(uid);
    // print(uemail);
    // print("${contactsList[0].email} + ${contactsList[0].email}");
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
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: contactsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTapDown: (TapDownDetails details) {
                      _showPopupMenu(context, index, details.globalPosition);
                    },
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        chatScreen.id,
                        arguments: [
                          uemail,
                          contactsList[index].email,
                          contactsList[index].contactId,
                          contactsList[index].name,
                        ],
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: contactCard(name: contactsList[index].name!),
                    ),
                  );
                },
              ),
      ),
    );
  }

  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  void addContact(String names, String emails, String userId) {
    final existingContact = contactsList.cast<ContactsModel?>().firstWhere(
          (contact) => contact?.email == emails,
          orElse: () => null,
        );

    if (existingContact != null) {
      snackbar(context, "Contact already exists");
      print('Contact already exists');
    } else {
      final newContact =
          ContactsModel(name: names, email: emails, contactId: userId);
      int id = 0;
      setState(() {
        contactsList.add(newContact);
        id = contactsList.indexOf(newContact);
        contacts.add({
          "contacting Id": id,
          'user email': uemail,
          'user id': uid,
          'contact email': emails,
          'contact name': names,
          'contact id': userId,
        });
      });
      snackbar(context, "Contact added");
      // print('New contact added: $contactName');
      // print('New contact added: $contactEmail'); // print("contact List is: ${contactsList[]}");
    }
  }

  // getContacts() {
  //   final document = getUserEmail();
  //   final newContact =
  //       ContactsModel(name: names, email: emails, contactId: userId);
  // }

  // Future<String> getUserEmail() async {
  //   DocumentSnapshot doc =
  //       await FirebaseFirestore.instance.collection('contacts').doc().get();
  //   if (FirebaseAuth.instance.currentUser!.email == doc['user email']) {
  //     return doc['user email'];
  //   } else {
  //     return "";
  //   }
  // }
  Future<void> getUserContacts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userEmail = user.email;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Contacts')
          .where('user email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          final document = querySnapshot.docs.elementAt(i);
          final contactName = document['contact name'];
          final contactEmail = document['contact email'];
          final contactId = document['contact id'];
          final Contact = ContactsModel(
              name: contactName, email: contactEmail, contactId: contactId);
          contactsList.add(Contact);
          setState(() {});
          // Retrieve other fields as needed

          print('Contact Name: $contactName');
          print('Contact Email: $contactEmail');

          setState(() {
            isLoading = false;
          });
        }
        // Print other fields
      } else {
        print('No matching document found.');
      }
    } else {
      print('User not signed in.');
    }
  }

  void onSubmit() async {
    final contactEmail = _contactEmailController.text;
    final contactName = _contactNameController.text;

    if (contactEmail == uemail) {
      snackbar(context, "You can't add yourself");
    } else {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: contactEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Assuming each user has a unique email, we'll take the first result
          final userDoc = querySnapshot.docs.first;
          print(userDoc);
          final userId = userDoc['uid'];
          print("User ID is :$userId");
          addContact(contactName, contactEmail, userId);

          Navigator.pop(context); // Close the dialog
          _contactEmailController.clear();
          _contactNameController.clear();
        } else {
          print('User with email $contactEmail not found.');
          snackbar(context, "The email does not exist");
        }
      } catch (e) {
        print('Error fetching user: $e');
        return null;
      }
      print('New contact added: $contactName');
      print('New contact added: $contactEmail');
    }
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

  void _showPopupMenu(
      BuildContext context, int index, Offset tapPosition) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        tapPosition & const Size(40, 40), // Smaller rect, the touch area
        Offset.zero & overlay.size, // Bigger rect, the entire screen
      ),
      items: [
        PopupMenuItem<String>(
          value: 'delete',
          onTap: () {
            deleteContact(contactsList[index].email!);
          },
          child: const Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8), // Assuming kDefaultPadding is 8
              Text('Delete'),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  Future<void> deleteContact(String email) async {
    // Find the contact in the local list
    final contactIndex =
        contactsList.indexWhere((contact) => contact.email == email);

    if (contactIndex != -1) {
      // Remove from local list
      setState(() {
        contactsList.removeAt(contactIndex);
      });

      // Remove from Firestore
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userEmail = user.email;
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Contacts')
            .where('user email', isEqualTo: userEmail)
            .where('contact email', isEqualTo: email)
            .get();

        for (var document in querySnapshot.docs) {
          await FirebaseFirestore.instance
              .collection('Contacts')
              .doc(document.id)
              .delete();
        }

        snackbar(context, "Contact deleted");
      } else {
        print('User not signed in.');
      }
    } else {
      snackbar(context, "Contact not found");
    }
  }
}


// class _HomeScreenState extends State<HomeScreen> {
//   final contacts = FirebaseFirestore.instance.collection(kContacts);
//   List<ContactsModel> contactsList = [];
//   final uid = FirebaseAuth.instance.currentUser!.uid;
//   final uemail = FirebaseAuth.instance.currentUser!.email;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     getUserContacts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddContactDialog(context);
//         },
//         child: const Icon(Icons.person_add_alt_rounded),
//       ),
//       appBar: appBarhomeScreen(context),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : ListView.builder(
//                 itemCount: contactsList.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         chatScreen.id,
//                         arguments: [
//                           uemail,
//                           contactsList[index].email,
//                           contactsList[index].contactId,
//                           contactsList[index].name,
//                         ],
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(kDefaultPadding / 2),
//                       child: contactCard(name: contactsList[index].name!),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }

//   final TextEditingController _contactNameController = TextEditingController();
//   final TextEditingController _contactEmailController = TextEditingController();

//   void addContact(String names, String emails, String userId) {
//     final existingContact = contactsList.cast<ContactsModel?>().firstWhere(
//           (contact) => contact?.email == emails,
//           orElse: () => null,
//         );

//     if (existingContact != null) {
//       snackbar(context, "Contact already exists");
//       print('Contact already exists');
//     } else {
//       final newContact =
//           ContactsModel(name: names, email: emails, contactId: userId);
//       int id = 0;
//       setState(() {
//         contactsList.add(newContact);
//         id = contactsList.indexOf(newContact);
//         contacts.add({
//           "contacting Id": id,
//           'user email': uemail,
//           'user id': uid,
//           'contact email': emails,
//           'contact name': names,
//           'contact id': userId,
//         });
//       });
//       snackbar(context, "Contact added");
//       // print('New contact added: $contactName');
//       // print('New contact added: $contactEmail');
//     }
//   }

//   Future<void> getUserContacts() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final userEmail = user.email;
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('Contacts')
//           .where('user email', isEqualTo: userEmail)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         for (var i = 0; i < querySnapshot.docs.length; i++) {
//           final document = querySnapshot.docs.elementAt(i);
//           final contactName = document['contact name'];
//           final contactEmail = document['contact email'];
//           final contactId = document['contact id'];
//           final Contact = ContactsModel(
//               name: contactName, email: contactEmail, contactId: contactId);
//           contactsList.add(Contact);
//           setState(() {});
//           print('Contact Name: $contactName');
//           print('Contact Email: $contactEmail');

//           setState(() {
//             isLoading = false;
//           });
//         }
//       } else {
//         print('No matching document found.');
//       }
//     } else {
//       print('User not signed in.');
//     }
//   }

//   void onSubmit() async {
//     final contactEmail = _contactEmailController.text;
//     final contactName = _contactNameController.text;

//     if (contactEmail == uemail) {
//       snackbar(context, "You can't add yourself");
//     } else {
//       try {
//         final querySnapshot = await FirebaseFirestore.instance
//             .collection('Users')
//             .where('email', isEqualTo: contactEmail)
//             .get();

//         if (querySnapshot.docs.isNotEmpty) {
//           // Assuming each user has a unique email, we'll take the first result
//           final userDoc = querySnapshot.docs.first;
//           print(userDoc);
//           final userId = userDoc['uid'];
//           print("User ID is :$userId");
//           addContact(contactName, contactEmail, userId);

//           Navigator.pop(context); // Close the dialog
//           _contactEmailController.clear();
//           _contactNameController.clear();
//         } else {
//           print('User with email $contactEmail not found.');
//           snackbar(context, "The email does not exist");
//         }
//       } catch (e) {
//         print('Error fetching user: $e');
//         return null;
//       }
//       print('New contact added: $contactName');
//       print('New contact added: $contactEmail');
//     }
//   }

//   void _showAddContactDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add Contact'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _contactNameController,
//                 decoration: const InputDecoration(hintText: 'Name'),
//               ),
//               TextField(
//                 controller: _contactEmailController,
//                 decoration: const InputDecoration(hintText: 'Email'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 onSubmit();
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
