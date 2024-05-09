// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bridgelt/models/doctor_model.dart';
import 'package:bridgelt/models/special_need_model.dart';
import 'package:bridgelt/models/volunteer_model.dart';
import 'package:bridgelt/modules/register/cubit/register_states.dart';
import 'package:bridgelt/modules/register/screen/forms/doctor/dr_form.dart';
import 'package:bridgelt/modules/register/screen/forms/special_needs/sp_form.dart';
import 'package:bridgelt/modules/register/screen/forms/volunteer/v_form.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
// import 'package:firebase_admin/firebase_admin.dart';
// import 'package:firebase_admin/src/credential.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  Color? drClr;
  Color? pClr;
  Color? snClr;
  bool isDrPics = false;
  bool isVPics = false;
  bool isSpPics = false;
  // bool isCSpPics = true;
  String selectedSpecialty = "Psychiatrist";
  String selectedDisability = "Visual Impairment";
  String selectedGov = 'Cairo';
  String selectedCity = 'Nasr City';
  var picker = ImagePicker();
  File? nIdDrImage;
  File? picDrImage;
  File? cardDrImage;
  File? nIdVImage;
  File? picVImage;
  File? nIdSpImage;
  File? picSpImage;
  File? cardSpImage;
  File? nIdCSpImage;
  File? picCSpImage;
  String? nIdDrImageName;
  String? picDrImageName;
  String? cardDrImageName;
  String? nIdVImageName;
  String? picVImageName;
  String? nIdSpImageName;
  String? picSpImageName;
  String? cardSpImageName;
  String? nIdCSpImageName;
  String? picCSpImageName;
  String? nIdDrImageUrl;
  String? picDrImageUrl;
  String? cardDrImageUrl;
  String? nIdVImageUrl;
  String? picVImageUrl;
  String? nIdSpImageUrl;
  String? picSpImageUrl;
  String? cardSpImageUrl;
  String? nIdCSpImageUrl;
  String? picCSpImageUrl;
  String? specialty;
  bool pass = true;
  bool rePass = true;
  IconData passIc = Icons.visibility_off_outlined;
  IconData rePassIc = Icons.visibility_off_outlined;
  var ctrlPass = TextEditingController();
  var ctrlRePass = TextEditingController();
  var ctrlUName = TextEditingController();
  var ctrlEMail = TextEditingController();
  var ctrlPhone = TextEditingController();
  bool isRematch = true;
  List<Face> faces = [];
  List<Face> face = [];

  void passVisible() {
    pass = !pass;
    if (pass) {
      passIc = Icons.visibility_off_outlined;
    } else {
      passIc = Icons.visibility_outlined;
    }
    emit(RegisterPasswordVisibleState());
  }

  void rePassVisible() {
    rePass = !rePass;
    if (rePass) {
      rePassIc = Icons.visibility_off_outlined;
    } else {
      rePassIc = Icons.visibility_outlined;
    }
    emit(RegisterRePasswordVisibleState());
  }

  void userRegister({
    required String name,
    required String email,
    required String pass,
    required String phone,
    String? specially,
    String? hospitalName,
    String? clinicAddress,
    String? doctorNationalIdNumber,
    String? doctorNationalIdImage,
    String? doctorPicture,
    String? syndicateCardImage,
    String? volunteerNationalIdNumber,
    String? volunteerHelp,
    String? volunteerGovernorate,
    String? volunteerCity,
    String? volunteerNationalIdPicture,
    String? volunteerPicture,
    String? specialNeedNationalIdNumber,
    String? typeOfDisabiliy,
    String? specialNeedGovernorate,
    String? specialNeedCity,
    String? specialNeedNationalIdPicture,
    String? specialNeedPicture,
    String? disablityCard,
    String? companionName,
    String? companionEmail,
    String? companionNationalIdNumber,
    String? companionNationalIdPicture,
    String? companionPicture,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then(
      (value) {
        if (drSelected) {
          doctorData(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid,
            specially: specially!,
            hospitalName: hospitalName!,
            clinicAddress: clinicAddress!,
            doctorNationalIdNumber: doctorNationalIdNumber!,
            doctorNationalIdImage: doctorNationalIdImage!,
            doctorPicture: doctorPicture!,
            syndicateCardImage: syndicateCardImage!,
          );
          print("=====================REG SUCC================");
          print(value.user?.email);
          print(value.user?.uid);
          emit(RegisterSuccState());
        } else if (vSelected) {
          volunteerData(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid,
            volunteerNationalIdNumber: volunteerNationalIdNumber!,
            volunteerHelp: volunteerHelp!,
            volunteerGovernorate: volunteerGovernorate!,
            volunteerCity: volunteerCity!,
            volunteerNationalIdPicture: volunteerNationalIdPicture!,
            volunteerPicture: volunteerPicture!,
          );
          print("=====================REG SUCC================");
          print(value.user?.email);
          print(value.user?.uid);
          emit(RegisterSuccState());
        } else if (spSelected) {
          specialNeedData(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid,
            specialNeedNationalIdNumber: specialNeedNationalIdNumber!,
            typeOfDisabiliy: typeOfDisabiliy!,
            specialNeedGovernorate: specialNeedGovernorate!,
            specialNeedCity: specialNeedCity!,
            specialNeedNationalIdPicture: specialNeedNationalIdPicture!,
            specialNeedPicture: specialNeedPicture!,
            disablityCard: disablityCard!,
            companionName: companionName!,
            companionEmail: companionEmail!,
            companionNationalIdNumber: companionNationalIdNumber!,
            companionNationalIdPicture: companionNationalIdPicture!,
            companionPicture: companionPicture!,
          );
          print("=====================REG SUCC================");
          print(value.user?.email);
          print(value.user?.uid);
          emit(RegisterSuccState());
        }
        // FirebaseAuthException(code: code)
      },
    ).catchError(
      (error) {
        print("REG Error = ${error.toString()}");
        emit(RegisterErrState(error.toString()));
      },
    );
  }

  void doctorData({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String specially,
    required String hospitalName,
    required String clinicAddress,
    required String doctorNationalIdNumber,
    required String doctorNationalIdImage,
    required String doctorPicture,
    required String syndicateCardImage,
  }) {
    DoctorData model = DoctorData(
      uId: uId,
      userType: 'Doctor',
      name: name,
      email: email,
      phone: phone,
      msg: ' ',
      isEmail: false,
      profileImage:
          'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=740&t=st=1700490559~exp=1700491159~hmac=0a3cc67a1ffce1192bdf53b5e974fd4340173b31eed80059600ea57ea8667da3',
      specially: specially,
      hospitalName: hospitalName,
      clinicAddress: clinicAddress,
      doctorNationalIdNumber: doctorNationalIdNumber,
      doctorNationalIdImage: doctorNationalIdImage,
      doctorPicture: doctorPicture,
      syndicateCardImage: syndicateCardImage,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print("Doctors DATA SAVED");
      emit(RegisterUserDataSuccState());
    }).catchError((error) {
      print("ERROR Doctors DATA ${error.toString()}");
      emit(RegisterUserDataErrState(error));
    });
  }

  void volunteerData({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String volunteerNationalIdNumber,
    required String volunteerHelp,
    required String volunteerGovernorate,
    required String volunteerCity,
    required String volunteerNationalIdPicture,
    required String volunteerPicture,
  }) {
    VolunteerData model = VolunteerData(
      uId: uId,
      userType: 'Volunteer',
      name: name,
      email: email,
      phone: phone,
      msg: "",
      isEmail: false,
      profileImage:
          'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=740&t=st=1700490559~exp=1700491159~hmac=0a3cc67a1ffce1192bdf53b5e974fd4340173b31eed80059600ea57ea8667da3',
      volunteerNationalIdNumber: volunteerNationalIdNumber,
      volunteerHelp: volunteerHelp,
      volunteerGovernorate: volunteerGovernorate,
      volunteerCity: volunteerCity,
      volunteerNationalIdPicture: volunteerNationalIdPicture,
      volunteerPicture: volunteerPicture,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print("volunteers DATA SAVED");
      emit(RegisterUserDataSuccState());
    }).catchError((error) {
      print("volunteers ERROR DATA ${error.toString()}");
      emit(RegisterUserDataErrState(error));
    });
  }

  void specialNeedData({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String specialNeedNationalIdNumber,
    required String typeOfDisabiliy,
    required String specialNeedGovernorate,
    required String specialNeedCity,
    required String specialNeedNationalIdPicture,
    required String specialNeedPicture,
    required String disablityCard,
    required String companionName,
    required String companionEmail,
    required String companionNationalIdNumber,
    required String companionNationalIdPicture,
    required String companionPicture,
  }) {
    SpecialNeedData model = SpecialNeedData(
      uId: uId,
      userType: 'SpecialNeed',
      name: name,
      email: email,
      phone: phone,
      msg: "",
      isEmail: false,
      profileImage:
          'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=740&t=st=1700490559~exp=1700491159~hmac=0a3cc67a1ffce1192bdf53b5e974fd4340173b31eed80059600ea57ea8667da3',
      specialNeedNationalIdNumber: specialNeedNationalIdNumber,
      typeOfDisabiliy: typeOfDisabiliy,
      specialNeedGovernorate: specialNeedGovernorate,
      specialNeedCity: specialNeedCity,
      specialNeedNationalIdPicture: specialNeedNationalIdPicture,
      specialNeedPicture: specialNeedPicture,
      disablityCard: disablityCard,
      companionName: companionName,
      companionEmail: companionEmail,
      companionNationalIdNumber: companionNationalIdNumber,
      companionNationalIdPicture: companionNationalIdPicture,
      companionPicture: companionPicture,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      print("specialneeds DATA SAVED");
      emit(RegisterUserDataSuccState());
    }).catchError((error) {
      print("specialneeds ERROR DATA ${error.toString()}");
      emit(RegisterUserDataErrState(error));
    });
  }

  void resetForm() {
    drSelected = false;
    vSelected = false;
    spSelected = false;
    drClr = null;
    pClr = null;
    snClr = null;

    emit(FormResetState());
  }

  void drBtn() {
    drSelected = true;
    vSelected = false;
    spSelected = false;

    if (drSelected) {
      drClr = const Color.fromARGB(255, 238, 234, 255);
      pClr = null;
      snClr = null;
    } else {
      drClr = null;
    }
    emit(FormDrSelectionState());
  }

  void vBtn() {
    drSelected = false;
    vSelected = true;
    spSelected = false;
    if (vSelected) {
      pClr = const Color.fromARGB(255, 238, 234, 255);
      drClr = null;
      snClr = null;
    } else {
      pClr = null;
    }
    emit(FormVSelectionState());
  }

  void spBtn() {
    drSelected = false;
    vSelected = false;
    spSelected = true;
    if (spSelected) {
      snClr = const Color.fromARGB(255, 238, 234, 255);
      pClr = null;
      drClr = null;
    } else {
      snClr = null;
    }
    emit(FormSNSelectionState());
  }

  void dropdown(String? val) {
    emit(FormDropDownState());
  }

  void govChoise(String? val) {
    selectedGov = val!;
    selectedCity = governorate[selectedGov]![0];

    emit(FormCityChoiseState());
  }

  Future<void> nIdDrPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      nIdDrImage = File(pickedFile.path);
      nIdDrImageName = basename(nIdDrImage!.path);
      // print("File Name: $fileName");
      emit(FormNIDDrImagePickerSuccState());
    } else {
      print("NO NIDDr IMG");
      emit(FormNIDDrImagePickerErrState());
    }
  }

  Future<void> picDrPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      picDrImage = File(pickedFile.path);
      picDrImageName = basename(picDrImage!.path);
      emit(FormPicDrImagePickerSuccState());
    } else {
      emit(FormPicDrImagePickerErrState());
    }
  }

  Future<void> cardDrPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      cardDrImage = File(pickedFile.path);
      cardDrImageName = basename(cardDrImage!.path);
      emit(FormCardDrImagePickerSuccState());
    } else {
      emit(FormCardDrImagePickerErrState());
    }
  }

  Future<void> nIdVPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      nIdVImage = File(pickedFile.path);
      nIdVImageName = basename(nIdVImage!.path);
      emit(FormNIDVImagePickerSuccState());
    } else {
      emit(FormNIDVImagePickerErrState());
    }
  }

  Future<void> picVPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      picVImage = File(pickedFile.path);
      picVImageName = basename(picVImage!.path);
      emit(FormPicVImagePickerSuccState());
    } else {
      emit(FormPicVImagePickerErrState());
    }
  }

  Future<void> nIdSpPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      nIdSpImage = File(pickedFile.path);
      nIdSpImageName = basename(nIdSpImage!.path);
      emit(FormNIDSpImagePickerSuccState());
    } else {
      emit(FormNIDSpImagePickerErrState());
    }
  }

  Future<void> picSpPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      picSpImage = File(pickedFile.path);
      picSpImageName = basename(picSpImage!.path);
      emit(FormPicSpImagePickerSuccState());
    } else {
      emit(FormPicSpImagePickerErrState());
    }
  }

  Future<void> cardSpPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      cardSpImage = File(pickedFile.path);
      cardSpImageName = basename(cardSpImage!.path);
      emit(FormCardSpImagePickerSuccState());
    } else {
      emit(FormCardSpImagePickerErrState());
    }
  }

  Future<void> nIdCSpPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      nIdCSpImage = File(pickedFile.path);
      nIdCSpImageName = basename(nIdCSpImage!.path);
      emit(FormNIDCSpImagePickerSuccState());
    } else {
      emit(FormNIDCSpImagePickerErrState());
    }
  }

  Future<void> picCSpPicker(ImageSource imgSource) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      picCSpImage = File(pickedFile.path);
      picCSpImageName = basename(picCSpImage!.path);
      emit(FormPicCSpImagePickerSuccState());
    } else {
      emit(FormPicCSpImagePickerErrState());
    }
  }

//drImgs
  void uploadNationaIdDrImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specially,
    required String hospitalName,
    required String clinicAddress,
    required String doctorNationalIdNumber,
  }) {
    emit(FormDrImagesUploadLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/Doctors/${ctrlEMail.text}/NationaIdImages/${Uri.file(nIdDrImage!.path).pathSegments.last}')
        .putFile(nIdDrImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // nIdDrImageUrl = value;
        uploadPictureDrImg(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specially: specially,
          hospitalName: hospitalName,
          clinicAddress: clinicAddress,
          doctorNationalIdNumber: doctorNationalIdNumber,
          doctorNationalIdImage: value,
        );
        emit(FormNIDDrImageUploadSuccState());
      }).catchError((error) {
        print("NID up01 ERR ${error.toString()}");
        emit(FormNIDDrImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("NID up02 ERR ${error.toString()}");
      emit(FormNIDDrImageUploadErrState(error.toString()));
    });
  }

  void uploadPictureDrImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specially,
    required String hospitalName,
    required String clinicAddress,
    required String doctorNationalIdNumber,
    required doctorNationalIdImage,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/Doctors/${ctrlEMail.text}/Pictures/${Uri.file(picDrImage!.path).pathSegments.last}')
        .putFile(picDrImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // picDrImageUrl = value;
        uploadCardDrImg(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specially: specially,
          hospitalName: hospitalName,
          clinicAddress: clinicAddress,
          doctorNationalIdNumber: doctorNationalIdNumber,
          doctorNationalIdImage: doctorNationalIdImage,
          doctorPicture: value,
        );
        emit(FormPicDrImageUploadSuccState());
      }).catchError((error) {
        print("Pic up01 ERR ${error.toString()}");
        emit(FormPicDrImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("Pic up02 ERR ${error.toString()}");
      emit(FormPicDrImageUploadErrState(error.toString()));
    });
  }

  void uploadCardDrImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specially,
    required String hospitalName,
    required String clinicAddress,
    required String doctorNationalIdNumber,
    required doctorNationalIdImage,
    required doctorPicture,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/Doctors/${ctrlEMail.text}/Cards/${Uri.file(cardDrImage!.path).pathSegments.last}')
        .putFile(cardDrImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // cardDrImageUrl = value;
        userRegister(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specially: specially,
          hospitalName: hospitalName,
          clinicAddress: clinicAddress,
          doctorNationalIdNumber: doctorNationalIdNumber,
          doctorNationalIdImage: doctorNationalIdImage,
          doctorPicture: doctorPicture,
          syndicateCardImage: value,
        );
        emit(FormCardDrImageUploadSuccState());
      }).catchError((error) {
        print("Card up01 ERR ${error.toString()}");
        emit(FormCardDrImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("Card up02 ERR ${error.toString()}");
      emit(FormCardDrImageUploadErrState(error.toString()));
    });
  }

//spImgs
  void uploadNationaIdSpImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specialNeedNationalIdNumber,
    required String typeOfDisabiliy,
    required String specialNeedGovernorate,
    required String specialNeedCity,
    required String companionName,
    required String companionEmail,
    required String companionNationalIdNumber,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/SpecialNeeds/${ctrlEMail.text}/SpecialNeed/NationaIdImages/${Uri.file(nIdSpImage!.path).pathSegments.last}')
        .putFile(nIdSpImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // nIdSpImageUrl = value;
        uploadPictureSpImg(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specialNeedNationalIdNumber: specialNeedNationalIdNumber,
          typeOfDisabiliy: typeOfDisabiliy,
          specialNeedGovernorate: specialNeedGovernorate,
          specialNeedCity: specialNeedCity,
          specialNeedNationalIdPicture: value,
          companionName: companionName,
          companionEmail: companionEmail,
          companionNationalIdNumber: companionNationalIdNumber,
        );
        emit(FormNIDSpImageUploadSuccState());
      }).catchError((error) {
        print("NID Sp up01 ERR ${error.toString()}");
        emit(FormNIDSpImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("NID Sp up02 ERR ${error.toString()}");
      emit(FormNIDSpImageUploadErrState(error.toString()));
    });
  }

  void uploadPictureSpImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specialNeedNationalIdNumber,
    required String typeOfDisabiliy,
    required String specialNeedGovernorate,
    required String specialNeedCity,
    required String specialNeedNationalIdPicture,
    required String companionName,
    required String companionEmail,
    required String companionNationalIdNumber,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/SpecialNeeds/SpecialNeed/${ctrlEMail.text}/Pictures/${Uri.file(picSpImage!.path).pathSegments.last}')
        .putFile(picSpImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // picSpImageUrl = value;
        uploadCardSpImg(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specialNeedNationalIdNumber: specialNeedNationalIdNumber,
          typeOfDisabiliy: typeOfDisabiliy,
          specialNeedGovernorate: specialNeedGovernorate,
          specialNeedCity: specialNeedCity,
          specialNeedNationalIdPicture: specialNeedNationalIdPicture,
          specialNeedPicture: value,
          companionName: companionName,
          companionEmail: companionEmail,
          companionNationalIdNumber: companionNationalIdNumber,
        );
        emit(FormPicSpImageUploadSuccState());
      }).catchError((error) {
        print("Pic Sp up01 ERR ${error.toString()}");
        emit(FormPicSpImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("Pic Sp up02 ERR ${error.toString()}");
      emit(FormPicSpImageUploadErrState(error.toString()));
    });
  }

  void uploadCardSpImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specialNeedNationalIdNumber,
    required String typeOfDisabiliy,
    required String specialNeedGovernorate,
    required String specialNeedCity,
    required String specialNeedNationalIdPicture,
    required String specialNeedPicture,
    required String companionName,
    required String companionEmail,
    required String companionNationalIdNumber,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/SpecialNeeds/SpecialNeed/${ctrlEMail.text}/Cards/${Uri.file(cardSpImage!.path).pathSegments.last}')
        .putFile(cardSpImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // cardSpImageUrl = value;
        uploadNationaIdCSpImg(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specialNeedNationalIdNumber: specialNeedNationalIdNumber,
          typeOfDisabiliy: typeOfDisabiliy,
          specialNeedGovernorate: specialNeedGovernorate,
          specialNeedCity: specialNeedCity,
          specialNeedNationalIdPicture: specialNeedNationalIdPicture,
          specialNeedPicture: specialNeedPicture,
          disablityCard: value,
          companionName: companionName,
          companionEmail: companionEmail,
          companionNationalIdNumber: companionNationalIdNumber,
        );
        emit(FormCardSpImageUploadSuccState());
      }).catchError((error) {
        print("Card Sp up01 ERR ${error.toString()}");
        emit(FormCardSpImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("Card Sp up02 ERR ${error.toString()}");
      emit(FormCardSpImageUploadErrState(error.toString()));
    });
  }

  void uploadNationaIdCSpImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specialNeedNationalIdNumber,
    required String typeOfDisabiliy,
    required String specialNeedGovernorate,
    required String specialNeedCity,
    required String specialNeedNationalIdPicture,
    required String specialNeedPicture,
    required String disablityCard,
    required String companionName,
    required String companionEmail,
    required String companionNationalIdNumber,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/SpecialNeeds/${ctrlEMail.text}/Companion/NationaIdImages/${Uri.file(nIdCSpImage!.path).pathSegments.last}')
        .putFile(nIdCSpImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // nIdCSpImageUrl = value;
        uploadPictureCSpImg(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specialNeedNationalIdNumber: specialNeedNationalIdNumber,
          typeOfDisabiliy: typeOfDisabiliy,
          specialNeedGovernorate: specialNeedGovernorate,
          specialNeedCity: specialNeedCity,
          specialNeedNationalIdPicture: specialNeedNationalIdPicture,
          specialNeedPicture: specialNeedPicture,
          disablityCard: disablityCard,
          companionName: companionName,
          companionEmail: companionEmail,
          companionNationalIdNumber: companionNationalIdNumber,
          companionNationalIdPicture: value,
        );
        emit(FormNIDCSpImageUploadSuccState());
      }).catchError((error) {
        print("NID CSp up01 ERR ${error.toString()}");
        emit(FormNIDCSpImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("NID CSp up02 ERR ${error.toString()}");
      emit(FormNIDCSpImageUploadErrState(error.toString()));
    });
  }

  void uploadPictureCSpImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String specialNeedNationalIdNumber,
    required String typeOfDisabiliy,
    required String specialNeedGovernorate,
    required String specialNeedCity,
    required String specialNeedNationalIdPicture,
    required String specialNeedPicture,
    required String disablityCard,
    required String companionName,
    required String companionEmail,
    required String companionNationalIdNumber,
    required String companionNationalIdPicture,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/SpecialNeeds/${ctrlEMail.text}/Companion/Pictures/${Uri.file(picCSpImage!.path).pathSegments.last}')
        .putFile(picCSpImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        // picCSpImageUrl = value;
        userRegister(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          specialNeedNationalIdNumber: specialNeedNationalIdNumber,
          typeOfDisabiliy: typeOfDisabiliy,
          specialNeedGovernorate: specialNeedGovernorate,
          specialNeedCity: specialNeedCity,
          specialNeedNationalIdPicture: specialNeedNationalIdPicture,
          specialNeedPicture: specialNeedPicture,
          disablityCard: disablityCard,
          companionName: companionName,
          companionEmail: companionEmail,
          companionNationalIdNumber: companionNationalIdNumber,
          companionNationalIdPicture: companionNationalIdPicture,
          companionPicture: value,
        );
        emit(FormPicCSpImageUploadSuccState());
      }).catchError((error) {
        print("Pic CSp up01 ERR ${error.toString()}");
        emit(FormPicCSpImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("Pic CSp up02 ERR ${error.toString()}");
      emit(FormPicCSpImageUploadErrState(error.toString()));
    });
  }

//VImgs
  void uploadNationaIdVImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String volunteerNationalIdNumber,
    required String volunteerHelp,
    required String volunteerGovernorate,
    required String volunteerCity,
  }) {
    emit(FormVImagesUploadLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/Volunteers/${ctrlEMail.text}/NationaIdImages/${Uri.file(nIdVImage!.path).pathSegments.last}')
        .putFile(nIdVImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        nIdVImageUrl = value;
        uploadPictureVImg(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          volunteerNationalIdNumber: volunteerNationalIdNumber,
          volunteerHelp: volunteerHelp,
          volunteerGovernorate: volunteerGovernorate,
          volunteerCity: volunteerCity,
          volunteerNationalIdPicture: value,
        );
        emit(FormNIDVImageUploadSuccState());
      }).catchError((error) {
        print("NID CSp up01 ERR ${error.toString()}");
        emit(FormNIDVImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("NID CSp up02 ERR ${error.toString()}");
      emit(FormNIDVImageUploadErrState(error.toString()));
    });
  }

  void uploadPictureVImg({
    required String name,
    required String email,
    required String pass,
    required String phone,
    required String volunteerNationalIdNumber,
    required String volunteerHelp,
    required String volunteerGovernorate,
    required String volunteerCity,
    required String volunteerNationalIdPicture,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'Users/Volunteers/${ctrlEMail.text}/Pictures/${Uri.file(picVImage!.path).pathSegments.last}')
        .putFile(picVImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        picVImageUrl = value;
        userRegister(
          name: name,
          email: email,
          pass: pass,
          phone: phone,
          volunteerNationalIdNumber: volunteerNationalIdNumber,
          volunteerHelp: volunteerHelp,
          volunteerGovernorate: volunteerGovernorate,
          volunteerCity: volunteerCity,
          volunteerNationalIdPicture: volunteerNationalIdPicture,
          volunteerPicture: value,
        );
        emit(FormPicVImageUploadSuccState());
      }).catchError((error) {
        print("Pic CSp up01 ERR ${error.toString()}");
        emit(FormPicVImageUploadErrState(error.toString()));
      });
    }).catchError((error) {
      print("Pic CSp up02 ERR ${error.toString()}");
      emit(FormPicVImageUploadErrState(error.toString()));
    });
  }

  Future detectFaces(File img) async {
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFilePath(img.path);
    faces = await faceDetector.processImage(inputImage);
    print("+++++++++++++++ ${faces.length}");
    emit(FormPicVImagePickerSuccState());
  }

  Future detectFace(File img) async {
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFilePath(img.path);
    face = await faceDetector.processImage(inputImage);
    print("+++++++++++++++ ${face.length}");
    emit(FormPicVImagePickerSuccState());
  }

  Future<void> imgPicker({
    required ImageSource imgSource,
    required File? imgFile,
    required String? imgName,
  }) async {
    final pickedFile = await picker.pickImage(
      source: imgSource,
    );

    if (pickedFile != null) {
      imgFile = File(pickedFile.path);
      imgName = basename(imgFile.path);
    }
  }

  Future<void> imgPickerOptions({
    required BuildContext context,
    // required File imgFile,
    // required String imgName,
    required Future<void> functionCam,
    required Future<void> functionGellary,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(13.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: txt(
                    context: context,
                    txt: "Open from",
                    bd: true,
                    isClr: true,
                    sz: 18,
                  ),
                ),
                const SizedBox(height: 23),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        functionCam;
                        // imgPicker(
                        //   imgSource: ImageSource.camera,
                        //   imgFile: imgFile,
                        //   imgName: imgName,
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 36,
                            ),
                            const SizedBox(height: 9),
                            txt(
                              context: context,
                              txt: "Camera",
                              sz: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 23),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        functionGellary;
                        // imgPicker(
                        //   imgSource: ImageSource.gallery,
                        //   imgFile: imgFile,
                        //   imgName: imgName,
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.photo_library_outlined,
                              size: 36,
                            ),
                            const SizedBox(height: 9),
                            txt(
                              context: context,
                              txt: "Gallery",
                              sz: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void clearBtn() {
    ctrlUName.clear();
    ctrlEMail.clear();
    ctrlPass.clear();
    ctrlRePass.clear();
    ctrlPhone.clear();
    isDrPics = false;
    nIdDrImage = null;
    picDrImage = null;
    cardDrImage = null;
    ctrlHospitalName.clear();
    ctrlClinicAddress.clear();
    ctrlDrNID.clear();
    isSpPics = false;
    ctrlEMail.clear();
    ctrlUName.clear();
    ctrlPass.clear();
    ctrlRePass.clear();
    ctrlPhone.clear();
    nIdSpImage = null;
    picSpImage = null;
    cardSpImage = null;
    nIdCSpImage = null;
    picCSpImage = null;
    ctrlSpNID.clear();
    ctrlCName.clear();
    ctrlCEMail.clear();
    ctrlCNID.clear();
    ctrlCNID.clear();
    isDrPics = false;
    ctrlEMail.clear();
    ctrlUName.clear();
    ctrlPass.clear();
    ctrlRePass.clear();
    ctrlPhone.clear();
    nIdVImage = null;
    picVImage = null;
    ctrlVNID.clear();
  }
}
