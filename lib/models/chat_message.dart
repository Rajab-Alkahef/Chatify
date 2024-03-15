import 'package:chat_app_new/constants.dart';

class MessageModel {
  final String message;
  // String createdAt;
  MessageModel(
    this.message,
    //  this.createdAt,
  );

  factory MessageModel.fromJson(jsondata) {
    return MessageModel(jsondata[kMessage]);
  }
}
