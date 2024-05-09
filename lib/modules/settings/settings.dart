// import 'package:bridgelt/layout/bridglet_layout.dart';
// import 'package:bridgelt/shared/components/components.dart';
// import 'package:bridgelt/shared/components/constants.dart';
// import 'package:bridgelt/shared/cubit/bridgelt/cubit.dart';
// import 'package:bridgelt/shared/cubit/bridgelt/states.dart';
// import 'package:flutter/material.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class Setting extends StatelessWidget {
//   const Setting({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<BridgeltCubit, BridgeltStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var app = BridgeltCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               onPressed: () {
//                 pgx(context, const Bridgelt());
//                 index = 0;
//               },
//               icon: back,
//             ),
//             centerTitle: true,
//             title: txt(context: context, txt: "Settings", sz: 23),
//           ),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     const SizedBox(width: 39),
//                     Text(
//                       "Select Theme: ",
//                       style: TextStyle(
//                         color: Theme.of(context).textTheme.bodyLarge!.color,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(width: 69),
//                     DropdownButton<String>(
//                       dropdownColor:
//                           Theme.of(context).textTheme.bodySmall!.color,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Theme.of(context).textTheme.bodyLarge!.color,
//                       ),
//                       value: app.selectedThm,
//                       onChanged: (String? newValue) {
//                         app.selectedThm = newValue!;
//                         app.chgMode(newValue);
//                       },
//                       items: <String>[
//                         'System Default',
//                         'Light Mode',
//                         'Dark Mode',
//                       ].map<DropdownMenuItem<String>>(
//                         (String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         },
//                       ).toList(),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 69),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// // Center(
// //         child: txt(
// //           context: context,
// //           txt: "It's Still Under Development",
// //           sz: 39,
// //           st: false,
// //           gy: true,
// //           clr: gy,
// //         ),
// //       ),
//
// class EncryptionPage extends StatefulWidget {
//   const EncryptionPage({super.key});
//
//   @override
//   EncryptionPageState createState() => EncryptionPageState();
// }
//
// class EncryptionPageState extends State<EncryptionPage> {
//   final TextEditingController _messageController = TextEditingController();
//   String _encryptedMessage = '';
//   String _decryptedMessage = ''; // إضافة متغير لتخزين الرسالة المفكوكة
//
//   // مفتاح و IV عشوائيين
//   final key = encrypt.Key.fromLength(32);
//   final iv = encrypt.IV.fromLength(16);
//
//   // دالة لتشفير الرسالة
//   void encryptMessage() {
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     final encrypted = encrypter.encrypt(_messageController.text, iv: iv);
//     setState(() {
//       _encryptedMessage = encrypted.base64;
//       _decryptedMessage = ''; // قم بمسح الرسالة المفكوكة عند تشفير رسالة جديدة
//     });
//   }
//
//   // دالة لفك تشفير الرسالة
//   void decryptMessage() {
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     final decrypted = encrypter.decrypt64(_encryptedMessage, iv: iv);
//     setState(() {
//       _decryptedMessage = decrypted;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Encryption Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _messageController,
//               decoration:
//                   const InputDecoration(labelText: 'Enter your message'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: encryptMessage,
//               child: const Text('Encrypt Message'),
//             ),
//             ElevatedButton(
//               onPressed: decryptMessage,
//               child: const Text('Decrypt Message'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Encrypted Message: $_encryptedMessage',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Decrypted Message: $_decryptedMessage', // عرض الرسالة المفكوكة
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
