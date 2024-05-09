// // // import 'package:bridgelt/models/chats.dart';
// // // import 'package:bridgelt/modules/messages/screen/messages.dart';
// // // import 'package:bridgelt/shared/components/components.dart';
// // // import 'package:bridgelt/shared/components/constants.dart';
// // // import 'package:bridgelt/shared/cubit/cubit.dart';
// // // import 'package:bridgelt/shared/cubit/states.dart';
// // // import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';

// // // class MessagesMenu extends StatelessWidget {
// // //   const MessagesMenu({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return BlocConsumer<AppCubit, AppStates>(
// // //       listener: (context, state) {},
// // //       builder: (context, state) {
// // //         var cubitApp = AppCubit.get(context);
// // //         return Scaffold(
// // //           appBar: AppBar(
// // //             leading: backBtn(context),
// // //             centerTitle: true,
// // //             title: txt(context: context, txt: "Messages", sz: 23),
// // //           ),
// // //           body: ConditionalBuilder(
// // //             condition: state is! AppLoadingChatsState,
// // //             builder: (context) => cubitApp.listOfChats.isNotEmpty
// // //                 ? ListView.separated(
// // //                     shrinkWrap: true,
// // //                     physics: const BouncingScrollPhysics(),
// // //                     itemBuilder: (context, index) =>
// // //                         messages(context, cubitApp.listOfChats[index]),
// // //                     separatorBuilder: (context, index) => const SizedBox(),
// // //                     itemCount: cubitApp.listOfChats.length,
// // //                   )
// // //                 : Center(
// // //                     child: txt(
// // //                       context: context,
// // //                       txt: "No Chats Yet",
// // //                       bd: true,
// // //                       isClr: true,
// // //                       sz: 29,
// // //                     ),
// // //                   ),
// // //             fallback: (context) =>
// // //                 Center(child: CircularProgressIndicator(color: bg)),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// // // // Widget messages(context, Chats model) => Padding(
// // // //       padding: const EdgeInsets.all(7.13),
// // // //       child: Card(
// // // //         surfaceTintColor: bg,
// // // //         shadowColor: bg,
// // // //         elevation: 3,
// // // //         clipBehavior: Clip.antiAliasWithSaveLayer,
// // // //         child: InkWell(
// // // //           onTap: () {
// // // //             pgn(
// // // //               context,
// // // //               MessagesScreen(model: model),
// // // //             );
// // // //           },
// // // //           child: Container(
// // // //             margin: const EdgeInsets.all(7),
// // // //             child: Column(
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 Row(
// // // //                   children: [
// // // //                     userType == "Volunteer"
// // // //                         ? CircleAvatar(
// // // //                             backgroundImage: NetworkImage(
// // // //                               model.receiverImage!,
// // // //                             ),
// // // //                             radius: 23,
// // // //                           )
// // // //                         : userType == "SpecialNeed"
// // // //                             ? CircleAvatar(
// // // //                                 backgroundImage: NetworkImage(
// // // //                                   model.senderImage!,
// // // //                                 ),
// // // //                                 radius: 23,
// // // //                               )
// // // //                             : CircleAvatar(
// // // //                                 backgroundImage: NetworkImage(
// // // //                                   model.receiverImage!,
// // // //                                 ),
// // // //                                 radius: 23,
// // // //                               ),
// // // //                     const SizedBox(width: 9),
// // // //                     Column(
// // // //                       children: [
// // // //                         userType == "Volunteer"
// // // //                             ? txt(
// // // //                                 txt: model.receiverName!,
// // // //                                 context: context,
// // // //                                 bd: true,
// // // //                               )
// // // //                             : userType == "SpecialNeed"
// // // //                                 ? txt(
// // // //                                     txt: model.senderName!,
// // // //                                     context: context,
// // // //                                     bd: true,
// // // //                                   )
// // // //                                 : txt(
// // // //                                     txt: model.receiverName!,
// // // //                                     context: context,
// // // //                                     bd: true,
// // // //                                   ),
// // // //                       ],
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );











// // void sendMessage({
// //   required String receivedId,
// //   required String time,
// //   required String message,
// // }) {
// //   // Encrypt the message using a key
// //   String encryptedMessage = encryptMessage(message);

// //   Messages model = Messages(
// //     senderId: uId,
// //     receiverId: receivedId,
// //     time: time,
// //     message: encryptedMessage, // Send the encrypted message
// //   );

// //   // Your existing code to emit loading state

// //   FirebaseFirestore.instance
// //       .collection('Users')
// //       .doc(uId)
// //       .collection('Chats')
// //       .doc(receivedId)
// //       .collection('Messages')
// //       .add(model.toJson())
// //       .then((value) {
// //     emit(AppSendMessagesSuccState());
// //   }).catchError((error) {
// //     emit(AppSendMessagesErrState(error.toString()));
// //   });

// //   // Your existing code for setting chats menu
// // }

// // // Function to encrypt the message
// // String encryptMessage(String message) {
// //   // Replace 'yourSecretKey' with your own secret key
// //   final key = 'yourSecretKey';
// //   final keyBytes = utf8.encode(key);
// //   final iv = IV.fromLength(16);

// //   final encrypter = Encrypter(AES(Key(keyBytes)));

// //   final encryptedMessage = encrypter.encrypt(message, iv: iv);

// //   return encryptedMessage.base64;
// // }





// // void getMessages({required String receiverId}) {
// //   emit(AppLoadingMessagesState());

// //   FirebaseFirestore.instance
// //       .collection('Users')
// //       .doc(uId)
// //       .collection('Chats')
// //       .doc(receiverId)
// //       .collection('Messages')
// //       .orderBy('time')
// //       .snapshots()
// //       .listen((event) {
// //     listOfMessages = [];
// //     for (var element in event.docs) {
// //       // Decrypt the message before adding it to the list
// //       String decryptedMessage = decryptMessage(element['message']);
// //       listOfMessages.add(Messages.fromJson(element.data(), decryptedMessage));
// //     }
// //     print("GET MSG");
// //     emit(AppGetMessagesState());
// //   });
// // }

// // // Function to decrypt the message
// // String decryptMessage(String encryptedMessage) {
// //   // Replace 'yourSecretKey' with your own secret key
// //   final key = 'yourSecretKey';
// //   final keyBytes = utf8.encode(key);
// //   final iv = IV.fromLength(16);

// //   final encrypter = Encrypter(AES(Key(keyBytes)));

// //   final decryptedMessage =
// //       encrypter.decrypt64(encryptedMessage, iv: iv);

// //   return decryptedMessage;
// // }



// // class Messages {
// //   String senderId;
// //   String receiverId;
// //   String time;
// //   String message;

// //   Messages({
// //     required this.senderId,
// //     required this.receiverId,
// //     required this.time,
// //     required this.message,
// //   });

// //   // Factory method to create Messages object from JSON data
// //   factory Messages.fromJson(Map<String, dynamic> json) {
// //     // Assuming the encrypted message is stored under the key 'message'
// //     final encryptedMessage = json['message'];
// //     // Decrypt the message
// //     final decryptedMessage = decryptMessage(encryptedMessage);

// //     return Messages(
// //       senderId: json['senderId'],
// //       receiverId: json['receiverId'],
// //       time: json['time'],
// //       message: decryptedMessage,
// //     );
// //   }
// // }


//   void sendMessage({
//     required String uId,
//     required String receivedId,
//     required String time,
//     required String message,
//   }) {
//     Messages model = Messages(
//       senderId: uId,
//       receiverId: receivedId,
//       time: time,
//       message: message,
//     );

//     emit(AppLoadingMessagesState());

//     FirebaseFirestore.instance
//         .collection('Users')
//         .doc(uId)
//         .collection('Chats')
//         .doc(receivedId)
//         .collection('Messages')
//         .add(model.toJson())
//         .then((value) {
//       emit(AppSendMessagesSuccState());
//     }).catchError((error) {
//       emit(AppSendMessagesErrState(error.toString()));
//     });

//     // Your other firestore code...
//   }

//   void getMessages({required String uId, required String receiverId}) {
//     emit(AppLoadingMessagesState());

//     FirebaseFirestore.instance
//         .collection('Users')
//         .doc(uId)
//         .collection('Chats')
//         .doc(receiverId)
//         .collection('Messages')
//         .orderBy('time')
//         .snapshots()
//         .listen((event) {
//       listOfMessages = event.docs.map((doc) => Messages.fromJson(doc.data())).toList();

//       print("GET MSG");
//       emit(AppGetMessagesState());
//     });
//   }



// The error message "Invalid argument(s): Invalid or corrupted pad block" typically indicates an issue with the initialization vector (IV) used during the decryption process. In your code, you are generating a new IV for every encryption and decryption, which might not be the same across the encryption and decryption process.

// To fix this issue, you should ensure that the same IV is used for both encryption and decryption. You can achieve this by storing the IV when encrypting the message and passing it to the decrypt function. Here's an updated version of your code with the IV stored during encryption:

// ```dart
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'dart:convert';

// class Messages {
//   String? senderId;
//   String? receiverId;
//   String? time;
//   String? message;

//   Messages({
//     this.senderId,
//     this.receiverId,
//     this.time,
//     this.message,
//   });

//   Messages.fromJson(Map<String, dynamic> json) {
//     senderId = json['senderId'];
//     receiverId = json['receiverId'];
//     time = json['time'];
//     message = decryptMessage(json['message'], json['iv']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'time': time,
//       'message': encryptMessage(message!),
//       'iv': encryptMessage(encrypt.IV.fromLength(16).toString()), // Add IV to JSON
//     };
//   }
// }

// String encryptMessage(String message) {
//   const key = '2Mw9X67yvfA2r9Fg0y3N5+kXt/vAd4lM';
//   final keyBytes = utf8.encode(key);

//   final iv = encrypt.IV.fromLength(28);

//   final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key(keyBytes)));

//   final encryptedMessage = encrypter.encrypt(message, iv: iv);

//   return encryptedMessage.base64;
// }

// String decryptMessage(String encryptedMessage, String iv) {
//   const key = '2Mw9X67yvfA2r9Fg0y3N5+kXt/vAd4lM';
//   final keyBytes = utf8.encode(key);

//   final ivDecoded = encrypt.IV.fromBase64(iv); // Convert IV from String