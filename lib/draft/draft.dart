// // ignore_for_file: avoid_print
//
// import 'package:flutter/material.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// class Draft extends StatelessWidget {
//   const Draft({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
// ////////////////////////////////////////////////////////////
//
// // class FaceDetectionScreen extends StatefulWidget {
// //   const FaceDetectionScreen({super.key});
//
// //   @override
// //   FaceDetectionScreenState createState() => FaceDetectionScreenState();
// // }
//
// // class FaceDetectionScreenState extends State<FaceDetectionScreen> {
// //   late CameraController _controller;
// //   late Future<void> _initializeControllerFuture;
// //   late FaceDetector _faceDetector;
//
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initializeCamera();
// //     _faceDetector = FirebaseVision.instance.faceDetector();
// //   }
//
// //   Future<void> _initializeCamera() async {
// //     final cameras = await availableCameras();
// //     final frontCamera = cameras.firstWhere(
// //         (camera) => camera.lensDirection == CameraLensDirection.front);
// //     _controller = CameraController(frontCamera, ResolutionPreset.high);
// //     _initializeControllerFuture = _controller.initialize();
// //     if (!mounted) {
// //       return;
// //     }
// //     setState(() {});
// //   }
//
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     _faceDetector.close();
// //     super.dispose();
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     if (!_controller.value.isInitialized) {
// //       return Container();
// //     }
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Face Detection')),
// //       body: FutureBuilder<void>(
// //         future: _initializeControllerFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.done) {
// //             return CameraPreview(_controller);
// //           } else {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _detectFaces,
// //         child: const Icon(Icons.camera_alt),
// //       ),
// //     );
// //   }
//
// //   //
// //   // void _detectFaces() async {
// //   //   if (!_controller.value.isInitialized) {
// //   //     return;
// //   //   }
// //   //
// //   //   try {
// //   //     await _initializeControllerFuture;
// //   //     final image =
// //   //         FirebaseVisionImage.fromBytes((await _controller.takePicture()).data);
// //   //
// //   //     List<Face> faces = await _faceDetector.processImage(image);
// //   //
// //   //     // Do something with detected faces
// //   //     print("Detected ${faces.length} face(s)");
// //   //     for (Face face in faces) {
// //   //       print('Face: ${face.boundingBox}');
// //   //     }
// //   //   } catch (e) {
// //   //     print(e);
// //   //   }
// //   // }
// //   //
// //   void _detectFaces() async {
// //     if (!_controller.value.isInitialized) {
// //       return;
// //     }
//
// //     try {
// //       await _initializeControllerFuture;
// //       XFile? imageFile = await _controller.takePicture();
//
// //       FirebaseVisionImage visionImage =
// //           FirebaseVisionImage.fromFilePath(imageFile.path);
//
// //       List<Face> faces = await _faceDetector.processImage(visionImage);
//
// //       // Do something with detected faces
// //       print("Detected ${faces.length} face(s)");
// //       for (Face face in faces) {
// //         print('Face: ${face.boundingBox}');
// //       }
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// // }
//
// //////////////////////////////////////////////////////////////////////////
// class EncryptionPage extends StatefulWidget {
//   const EncryptionPage({super.key});
//
//   @override
//   EncryptionPageState createState() => EncryptionPageState();
// }
//
// class EncryptionPageState extends State<EncryptionPage> {
  // final TextEditingController messageController = TextEditingController();
  // String encryptedMessage = '';
  // String decryptedMessage = ''; // إضافة متغير لتخزين الرسالة المفكوكة

  // // مفتاح و IV عشوائيين
  // final key = encrypt.Key.fromLength(32);
  // final iv = encrypt.IV.fromLength(16);

  // // دالة لتشفير الرسالة
  // void encryptMessage() {
  //   final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //   final encrypted = encrypter.encrypt(messageController.text, iv: iv);
  //   setState(() {
  //     encryptedMessage = encrypted.base64;
  //     decryptedMessage = ''; // قم بمسح الرسالة المفكوكة عند تشفير رسالة جديدة
  //   });
  // }

  // // دالة لفك تشفير الرسالة
  // void decryptMessage() {
  //   final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //   final decrypted = encrypter.decrypt64(encryptedMessage, iv: iv);
  //   setState(() {
  //     decryptedMessage = decrypted;
  //   });
  // }
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
//               controller: messageController,
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
//               'Encrypted Message: $encryptedMessage',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Decrypted Message: $decryptedMessage', // عرض الرسالة المفكوكة
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Future<void> fetchReceiverIDs() async {
// //   // استعلام Firestore لجلب الوثائق من مجموعة الدردشات
// //   QuerySnapshot chatSnapshot = await FirebaseFirestore.instance
// //       .collection('Users')
// //       .doc('user IDs')
// //       .collection('Chats')
// //       .get();
//
// //   // استخراج معرفات المستقبلين من الوثائق
// //   Set<String> receiverIDs = <String>{};
//
// //   for (var chatDoc in chatSnapshot.docs) {
// //     receiverIDs.add(chatDoc.data()['receiverID']);
// //   }
//
// //   // طباعة معرفات المستقبلين
// //   for (var receiverID in receiverIDs) {
// //     print(receiverID);
// //   }
// // }
//
//
//
// // void printChatDocuments() async {
// //   // استرجاع مرجع لمجموعة الوثائق في مجموعة الدردشات
// //   CollectionReference chatsCollection = FirebaseFirestore.instance.collection('Users').doc(userID).collection('Chats');
//
// //   // الحصول على كافة الوثائق في مجموعة الدردشات
// //   QuerySnapshot chatDocuments = await chatsCollection.get();
//
// //   // طباعة كل وثيقة
// //   for (var doc in chatDocuments.docs) {
// //     print('Document ID: ${doc.id}');
// //     print('Receiver ID: ${doc.data()['receiverID']}');
// //     // يمكنك طباعة المزيد من الحقول هنا حسب الحاجة
// //   }
// // }
//
// // // استدعاء الدالة لطباعة الوثائق
// // printChatDocuments();


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class BiometricAuth {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//   static final LocalAuthentication _localAuth = LocalAuthentication();

//   static Future<bool> isBiometricAvailable() async {
//     bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
//     if (canCheckBiometrics) {
//       List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
//       if (availableBiometrics.isNotEmpty) {
//         return true;
//       }
//     }
//     return false;
//   }

//   static Future<void> authenticateWithBiometrics() async {
//     bool isAvailable = await isBiometricAvailable();
//     if (!isAvailable) {
//       throw PlatformException(code: 'NOT_AVAILABLE', message: 'Biometric authentication is not available on this device.');
//     }

//     bool didAuthenticate = await _localAuth.authenticate(
//       localizedReason: 'Authenticate to sign in',
//       options: const AuthenticationOptions(
//         useErrorDialogs: true,
//         stickyAuth: true,
//       ),
//     );

//     if (didAuthenticate) {
//       // Sign in the user with Firebase
//       await _auth.signInWithCredential(
//         FirebaseCredential(
//           signInMethod: 'biometric',
//           signInProvider: 'biometric',
//           accessToken: 'biometric',
//         ),
//       );
//     } else {
//       throw PlatformException(code: 'AUTHENTICATION_FAILED', message: 'Biometric authentication failed.');
//     }
//   }
// }


// First, integrate platform-specific biometric authentication libraries:
// For Android: https://pub.dev/packages/local_auth
// For iOS: https://pub.dev/packages/local_auth_ios

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:local_auth/local_auth.dart';

// class BiometricAuthScreen extends StatelessWidget {
//   final LocalAuthentication localAuth = LocalAuthentication();

//   BiometricAuthScreen({super.key});

//   Future<void> authenticate() async {
//     bool didAuthenticate = false;
//     try {
//       didAuthenticate = await localAuth.authenticate(
//         localizedReason: 'Please authenticate to log in',
//       );
//     } catch (e) {
//       // Handle authentication errors
//     }

//     if (didAuthenticate) {
//       // Authentication successful, proceed with Firebase sign-in
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
//         // Handle successful sign-in
//       } catch (e) {
//         // Handle Firebase sign-in errors
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Biometric Authentication')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: authenticate,
//           child: Text('Authenticate with Biometrics'),
//         ),
//       ),
//     );
//   }
// }
