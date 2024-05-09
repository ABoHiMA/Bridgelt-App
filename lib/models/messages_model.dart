import 'package:bridgelt/shared/cubit/cubit.dart';

class Messages {
  String? messageId;
  String? senderId;
  String? receiverId;
  String? time;
  String? message;

  Messages({
    this.messageId,
    this.senderId,
    this.receiverId,
    this.time,
    this.message,
  });

  Messages.fromJson(Map<String, dynamic> json, context) {
    messageId = json['messageId'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    time = json['time'];
    message = AppCubit.get(context).decryptMessage(json['message']);
  }

  Map<String, dynamic> toJson(context) {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'time': time,
      'message': AppCubit.get(context).encryptMessage(message!),
    };
  }
}
