import 'package:chat_app_new/constants.dart';
import 'package:chat_app_new/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class chatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendmessage(
      String recieverId, String message, String reciverEmail) async {
    final String userId = _firebaseAuth.currentUser!.uid;
    final String usesrEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    MessageModel newmessage = MessageModel(
      message,
      userId,
      usesrEmail,
      recieverId,
      reciverEmail,
      timestamp,
    );
    List<String> ids = [userId, recieverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection(kMessageCollection)
        .add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getmessages(String userId, String friendId) {
    List<String> ids = [userId, friendId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection(kMessageCollection)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
