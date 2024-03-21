import 'package:chat_app_new/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String reciverEmail;
  final Timestamp timestamp;

  // String createdAt;
  MessageModel(
    this.message,
    this.senderId,
    this.senderEmail,
    this.recieverId,
    this.reciverEmail,
    this.timestamp,
  );

  // factory MessageModel.fromJson(jsondata) {
  //   return MessageModel(
  //     jsondata[kMessage],
  //     jsondata[kUserId],
  //     jsondata[kUserEmail],
  //     jsondata[kfriendId],
  //     jsondata[kFreindEmail],
  //     jsondata['timeStamp'],
  //   );
  // }
  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "senderId": senderId,
      "senderEmail": senderEmail,
      "recieverId": recieverId,
      "reciverEmail": reciverEmail,
      "timestamp": timestamp
    };
  }
}
