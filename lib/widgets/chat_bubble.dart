import 'package:chat_app_new/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class chatBubble extends StatelessWidget {
//    chatBubble({
//    DocumentSnapshot? document,
//     super.key,
//   });

//   Map<String, dynamic> data = document.
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         decoration: const BoxDecoration(
//           color: kPrimaryColor,
//           borderRadius: BorderRadius.all(Radius.circular(32)),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         margin: const EdgeInsets.all(8),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             message.message,
//             style: TextStyle(
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? Colors.black
//                     : Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

Widget chatBubble(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

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
        child: Column(
          children: [
            Text(
              data['senderEmail'],
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              data['message'],
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}
