// ignore_for_file: avoid_print, await_only_futures
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/fingerprint/fingerprint.dart';
import 'package:bridgelt/models/cases_model.dart';
import 'package:bridgelt/models/doctor_model.dart';
import 'package:bridgelt/models/messages_model.dart';
import 'package:bridgelt/models/session_model.dart';
import 'package:bridgelt/models/special_need_model.dart';
import 'package:bridgelt/models/user_model.dart';
import 'package:bridgelt/models/volunteer_model.dart';
import 'package:bridgelt/modules/home/doctor/doctor_home.dart';
import 'package:bridgelt/modules/home/specialNeed/specialneed_home.dart';
import 'package:bridgelt/modules/home/volunteer/volunteer_home.dart';
import 'package:bridgelt/modules/profile/doctor/doctor_profile.dart';
import 'package:bridgelt/modules/profile/specialneed/specialneed_profile.dart';
import 'package:bridgelt/modules/profile/volunteer/volunteer_profile.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:bridgelt/shared/network/local/cache_h.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  late SpecialNeedData spModel;
  late VolunteerData vModel;
  late DoctorData drModel;
  late Messages msgModel;
  late Cases caseModel;
  late UserData userModel;
  List<UserData> listOfUsers = [];
  List<Messages> listOfMessages = [];
  List<SpecialNeedData> spUsers = [];
  List<VolunteerData> vUsers = [];
  List<DoctorData> drUsers = [];
  List<Cases> listOfVCases = [];
  List<Cases> listOfDrCases = [];
  List<Cases> listOfSpCases = [];
  List<Cases> listOfFilteredVCases = [];
  List<Cases> listOfFilteredDrCases = [];
  List<Cases> listOfArchivedCases = [];
  List<Sessions> listOfArchivedSessions = [];
  List<Sessions> listOfSessions = [];
  List<Sessions> listOfDrSessions = [];
  String selectedCurrentGov = 'Cairo';
  String selectedCurrentCity = 'Nasr City';
  late String? selectedGov = userType == "SpecialNeed"
      ? spModel.specialNeedGovernorate
      : userType == "Volunteer"
          ? vModel.volunteerGovernorate
          : 'Cairo';
  late String? selectedCity = userType == "SpecialNeed"
      ? spModel.specialNeedCity
      : userType == "Volunteer"
          ? vModel.volunteerCity
          : 'Nasr City';
  String? otherUId;
  String? otherName;
  String? otherImg;
  bool isProfile = false;
  bool isMessage = false;
  bool isFilter = false;
  bool name = false;
  bool phone = false;
  bool hospital = false;
  bool clinic = false;
  bool link = false;
  bool gov = false;
  bool isEdit = true;
  var picker = ImagePicker();
  File? profileimage;
  String? selectedFilteredGovernorate;
  String? selectedFilteredCity;
  var ctrlMsg = TextEditingController();
  bool isMsgBtn = true;
  var ctrlCase = TextEditingController();
  bool isCaseBtn = true;
  var ctrlSession = TextEditingController();
  bool isSessionBtn = true;
  String? messagegId;
  String encryptedMessage = '';
  String decryptedMessage = '';
  FingerPrint finger = FingerPrint();
  bool isSwitchChecked = fPrint.isNotEmpty;

  void msgFieldListener() {
    isMsgBtn = ctrlMsg.text.isEmpty;
    emit(AppMsgBtnState());
  }

  void caseFieldListener() {
    isMsgBtn = ctrlMsg.text.isEmpty;
    emit(AppMsgBtnState());
  }

  void sessionFieldListener() {
    isSessionBtn = ctrlSession.text.isEmpty;
    emit(AppMsgBtnState());
  }

  void dropdown(String? val) {
    emit(AppDropDownState());
  }

  void choiseCurrentGov(String? val) {
    selectedCurrentGov = val!;
    selectedCurrentCity = governorate[selectedCurrentGov]![0];

    emit(AppCityChoiseState());
  }

  void choiseGov(String? val) {
    selectedGov = val!;
    selectedCity = governorate[selectedGov]![0];

    emit(AppCityChoiseState());
  }

  List<String> titles = [
    "Cases",
    "Profile",
  ];

  List<Widget> drScreens = [
    const DoctorHomePage(),
    Container(),
    const DoctorProfile(),
  ];

  List<Widget> spScreens = [
    const SpecialNeedHomePage(),
    Container(),
    const SpecialNeedProfile(),
  ];

  List<Widget> vScreens = [
    const VolunteerHomePage(),
    const VolunteerProfile(),
  ];

  List<FloatingNavbarItem>? items = [
    FloatingNavbarItem(icon: Icons.home_filled),
    FloatingNavbarItem(customWidget: Container()),
    FloatingNavbarItem(icon: Icons.person_2_outlined),
  ];

  List<FloatingNavbarItem>? itemsV = [
    FloatingNavbarItem(icon: Icons.home_filled),
    FloatingNavbarItem(icon: Icons.person_2_outlined),
  ];

  void chgBtmNav(int inx) {
    index = inx;
    if (userType == "Volunteer") {
      if (inx == 0) {
        getUserData();
        // isFilter ? getFilteredVCases() : getVCases();
        emit(AppChgNavBarState());
      }
      emit(AppChgNavBarState());
    } else if (userType == "SpecialNeed") {
      if (inx == 0) {
        getUserData();
        emit(AppChgNavBarState());
      } else if (inx == 2) {
        getSpCases();
        emit(AppChgNavBarState());
      }
      emit(AppChgNavBarState());
    } else if (userType == "Doctor") {
      if (inx == 0) {
        getUserData();
        // isFilter ? getFilteredDrCases() : getDrCases();
        emit(AppChgNavBarState());
      } else if (inx == 2) {
        getDrSessions();
        emit(AppChgNavBarState());
      }
      emit(AppChgNavBarState());
    }
    emit(AppChgNavBarState());
  }

  void homeBtn() {
    index = 0;
    emit(AppChgNavBarState());
  }

  void userLogout() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(AppLogoutSuccState());
    }).catchError((error) {
      emit(AppLogoutErrState(error.toString()));
    });
  }

  void getUserData() {
    emit(AppLoadingGetUserDataState());

    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      print(value.data());
      print(userType);
      userType = value.data()?['userType'];
      verify = value.data()?['isEmail'];
      msgTeam = value.data()?['msg'];
      print(userType);

      userType == "Doctor"
          ? drModel = DoctorData.fromJson(value.data())
          : userType == "SpecialNeed"
              ? spModel = SpecialNeedData.fromJson(value.data())
              : userType == "Volunteer"
                  ? vModel = VolunteerData.fromJson(value.data())
                  : print("NO DATA");

      CacheHelper.saveData(key: 'userType', val: userType);
      CacheHelper.saveData(key: 'verify', val: verify);

      if (userType == "SpecialNeed") {
        getSessions();
        getSpCases();
      } else if (userType == "Volunteer") {
        isFilter ? getFilteredVCases() : getVCases();
      } else if (userType == "Doctor") {
        isFilter ? getFilteredDrCases() : getDrCases();
        getDrSessions();
      }
      getChats();
      print("SUCC GET DATA");
      emit(AppGetUserDataSuccState());
    }).catchError((error) {
      print("ERROR GET DATA ${error.toString()}");
      emit(AppGetUserDataErrState(error.toString()));
    });
  }

  void getOtherUserData({required String uid}) {
    otherUId = uid;
    emit(AppLoadingGetOthersUserDataState());

    FirebaseFirestore.instance.collection('Users').doc(uid).get().then((value) {
      // print("=======------************SUCC GET DATA ${value.data()?['name']}");
      otherName = value.data()?['name'];
      otherImg = value.data()?['profileImage'];
      if (userType == "SpecialNeed") {
        drModel = DoctorData.fromJson(value.data());
      } else {
        spModel = SpecialNeedData.fromJson(value.data());
      }

      emit(AppGetOthersUserDataSuccState());
    }).catchError((error) {
      print("ERROR GET DATA ${error.toString()}");
      emit(AppGetOthersUserDataErrState(error.toString()));
    });
  }

  void getSpecialNeedCaseChat({required String otheruid}) {
    otherUId = otheruid;
    emit(AppLoadingGetOthersUserChatState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(otheruid)
        .get()
        .then((value) {
      otherName = value.data()?['name'];
      otherImg = value.data()?['profileImage'];

      // print("=======------************SUCC GET DATA ${value.data()?['name']}");

      spModel = SpecialNeedData.fromJson(value.data());

      emit(AppGetOthersUserChatSuccState());
    }).catchError((error) {
      print("ERROR GET DATA ${error.toString()}");
      emit(AppGetOthersUserChatErrState(error.toString()));
    });
  }

  void createCase({
    required String text,
    required String time,
    required String gov,
    required String city,
  }) {
    emit(AppCreateCaseLoadingState());

    Cases model = Cases(
      caseId: 'ae',
      uId: spModel.uId,
      name: spModel.name,
      profileImage: spModel.profileImage,
      time: time,
      text: text,
      gov: gov,
      city: city,
      typeOfDisabiliy: spModel.typeOfDisabiliy,
      isMsg: false,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Cases')
        .add(model.toMap())
        .then((value) {
      Cases caseModel = Cases(
        caseId: value.id,
        uId: spModel.uId,
        name: spModel.name,
        profileImage: spModel.profileImage,
        time: time,
        text: text,
        gov: gov,
        city: city,
        typeOfDisabiliy: spModel.typeOfDisabiliy,
        isMsg: false,
      );
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('Cases')
          .doc(value.id)
          .update(caseModel.toMap());
      getUserData();
      emit(AppCreateCaseSuccState());
    }).catchError((error) {
      print("ERR CASE ${error.toString()}");
      emit(AppCreateCaseErrState(error.toString()));
    });
  }

  void deleteCase({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Cases')
        .doc(id)
        .delete()
        .then((value) {
      getSpCases();
      emit(AppDeleteCasesSuccState());
    }).catchError((error) {
      emit(AppDeleteCasesErrState(error.toString()));
    });
  }

  void archiveCase({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Cases')
        .doc(id)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('ArchivedCases')
          .doc(id)
          .set(data!)
          .then((value) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('Cases')
            .doc(id)
            .delete()
            .then((value) => getSpCases());
      }).catchError((error) {
        print('Error archive document: $error');
        emit(AppArchivedCasesErrState(error.toString()));
      });
      print('Document archive successfully');
      emit(AppArchivedCasesSuccState());
    }).catchError((error) {
      print('Error archive document: $error');
      emit(AppArchivedCasesErrState(error.toString()));
    });
  }

  void unArchiveCase({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedCases')
        .doc(id)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('Cases')
          .doc(id)
          .set(data!)
          .then((value) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('ArchivedCases')
            .doc(id)
            .delete()
            .then((value) => getArchiveCase());
      }).catchError((error) {
        print('Error archive document: $error');
        emit(AppArchivedCasesErrState(error.toString()));
      });
      print('Document archive successfully');
      emit(AppArchivedCasesSuccState());
    }).catchError((error) {
      print('Error archive document: $error');
      emit(AppArchivedCasesErrState(error.toString()));
    });
  }

  void getArchiveCase() {
    listOfArchivedCases.clear();
    emit(AppLoadingGetSpCasesState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedCases')
        .get()
        .then((value) {
      for (var element in value.docs) {
        listOfArchivedCases.add(Cases.fromJson(element.data()));
      }
      emit(AppArchivedCasesSuccState());
    }).catchError((error) {
      emit(AppArchivedCasesErrState(error.toString()));
    });
  }

  void deleteArchiveCase({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedCases')
        .doc(id)
        .delete()
        .then((value) {
      getArchiveCase();
      emit(AppDeleteCasesSuccState());
    }).catchError((error) {
      emit(AppDeleteCasesErrState(error.toString()));
    });
  }

  void getDrCases() {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      listOfDrCases.clear();
      emit(AppLoadingGetCasesState());
      for (QueryDocumentSnapshot userDoc in value.docs) {
        userDoc.reference
            .collection('Cases')
            .orderBy('time', descending: true)
            .get()
            .then((value) {
          for (var element in value.docs) {
            listOfDrCases.add(Cases.fromJson(element.data()));
          }
          emit(AppGetCasesSuccState());
        }).catchError((error) {
          print("!@@@@@@@@@@@@${error.toString()}");
          emit(AppGetCasesErrState(error.toString()));
        });
      }
    }).catchError((error) {
      print("!@@@@@@@@@@@@${error.toString()}");
      emit(AppGetCasesErrState(error.toString()));
    });
  }

  void getVCases() {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      listOfVCases.clear();
      emit(AppLoadingGetCasesState());

      for (QueryDocumentSnapshot userDoc in value.docs) {
        userDoc.reference
            .collection('Cases')
            .orderBy('time', descending: true)
            .get()
            .then((value) {
          for (var element in value.docs) {
            Map<String, dynamic> data = element.data();
            var volunteerHelp = vModel.volunteerHelp;
            if (volunteerHelp!.contains(data['typeOfDisabiliy'])) {
              listOfVCases.add(Cases.fromJson(data));
            }
          }
          emit(AppGetCasesSuccState());
        }).catchError((error) {
          print("!@@@@@@@@@@@@${error.toString()}");
          emit(AppGetCasesErrState(error.toString()));
        });
      }
      emit(AppGetCasesSuccState());
    }).catchError((error) {
      print("!@@@@@@@@@@@@${error.toString()}");
      emit(AppGetCasesErrState(error.toString()));
    });
  }

  void getFilteredVCases() {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      listOfFilteredVCases.clear();
      emit(AppLoadingGetFilteredCasesState());
      for (QueryDocumentSnapshot userDoc in value.docs) {
        userDoc.reference
            .collection('Cases')
            .where('gov', isEqualTo: selectedFilteredGovernorate)
            .get()
            .then((value) {
          for (var element in value.docs) {
            Map<String, dynamic> data = element.data();
            var volunteerHelp = vModel.volunteerHelp;
            if (volunteerHelp!.contains(data['typeOfDisabiliy'])) {
              listOfFilteredVCases.add(Cases.fromJson(element.data()));
            }
          }
          emit(AppGetFilteredCasesSuccState());
        }).catchError((error) {
          print("!@@@@@@@@@@@@${error.toString()}");
          emit(AppGetFilteredCasesErrState(error.toString()));
        });
      }
    }).catchError((error) {
      print("!@@@@@@@@@@@@${error.toString()}");
      emit(AppGetFilteredCasesErrState(error.toString()));
    });
  }

  void getFilteredDrCases() {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      listOfFilteredDrCases.clear();
      emit(AppLoadingGetFilteredCasesState());
      for (QueryDocumentSnapshot userDoc in value.docs) {
        userDoc.reference
            .collection('Cases')
            .where('gov', isEqualTo: selectedFilteredGovernorate)
            .get()
            .then((value) {
          for (var element in value.docs) {
            listOfFilteredDrCases.add(Cases.fromJson(element.data()));
          }
          emit(AppGetFilteredCasesSuccState());
        }).catchError((error) {
          print("!@@@@@@@@@@@@${error.toString()}");
          emit(AppGetFilteredCasesErrState(error.toString()));
        });
      }
    }).catchError((error) {
      print("!@@@@@@@@@@@@${error.toString()}");
      emit(AppGetFilteredCasesErrState(error.toString()));
    });
  }

  void getSpCases() {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      listOfSpCases.clear();
      emit(AppLoadingGetSpCasesState());
      for (QueryDocumentSnapshot userDoc in value.docs) {
        userDoc.reference
            .collection('Cases')
            .where('uId', isEqualTo: uId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            listOfSpCases.add(Cases.fromJson(element.data()));
            print("DDDDDOOONNNEE===   ${element.data()["name"]}");
          }
          emit(AppGetSpCasesSuccState());
        }).catchError((error) {
          emit(AppGetSpCasesErrState(error.toString()));
        });
      }
    }).catchError((error) {
      emit(AppGetSpCasesErrState(error.toString()));
    });
  }

  void msgBtn({required String caseId}) {
    FirebaseFirestore.instance
        .collection('Cases')
        .doc(caseId)
        .update({'isMsg': true}).then((value) {
      emit(AppUpdateMsgCaseSuccState());
    }).catchError((error) {
      emit(AppUpdateMsgCaseErrState(error));
    });
  }

  void createSession({
    required String text,
    required String time,
    required String link,
  }) {
    emit(AppCreateSessionLoadingState());

    Sessions model = Sessions(
      sessionId: 'ae',
      uId: drModel.uId,
      name: drModel.name,
      profileImage: drModel.profileImage,
      time: time,
      text: text,
      link: link,
      specially: drModel.specially,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Sessions')
        .add(model.toMap())
        .then((value) {
      Sessions sessionModel = Sessions(
        sessionId: value.id,
        uId: drModel.uId,
        name: drModel.name,
        profileImage: drModel.profileImage,
        time: time,
        text: text,
        link: link,
        specially: drModel.specially,
      );
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('Sessions')
          .doc(value.id)
          .update(sessionModel.toMap());
      getUserData();
      emit(AppCreateSessionSuccState());
    }).catchError((error) {
      print("ERR Session ${error.toString()}");
      emit(AppCreateSessionErrState(error.toString()));
    });
  }

  void deleteSession({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Sessions')
        .doc(id)
        .delete()
        .then((value) {
      getSessions();
      print('Document deleted successfully');
      emit(AppDeleteSessionSuccState());
    }).catchError((error) {
      print('Error deleting document: $error');
    });
  }

  void archiveSession({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Sessions')
        .doc(id)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('ArchivedSessions')
          .doc(id)
          .set(data!)
          .then((value) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('Sessions')
            .doc(id)
            .delete()
            .then((value) => getDrSessions());
      }).catchError((error) {
        print('Error archive document: $error');
        emit(AppArchivedCasesErrState(error.toString()));
      });
      print('Document archive successfully');
      emit(AppArchivedCasesSuccState());
    }).catchError((error) {
      print('Error archive document: $error');
      emit(AppArchivedCasesErrState(error.toString()));
    });
  }

  void unArchiveSession({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedSessions')
        .doc(id)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('Sessions')
          .doc(id)
          .set(data!)
          .then((value) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('ArchivedSessions')
            .doc(id)
            .delete()
            .then((value) => getArchiveSession());
      }).catchError((error) {
        print('Error archive document: $error');
        emit(AppArchivedCasesErrState(error.toString()));
      });
      print('Document archive successfully');
      emit(AppArchivedCasesSuccState());
    }).catchError((error) {
      print('Error archive document: $error');
      emit(AppArchivedCasesErrState(error.toString()));
    });
  }

  void getArchiveSession() {
    listOfArchivedSessions.clear();
    emit(AppLoadingGetSessionsState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedSessions')
        .get()
        .then((value) {
      for (var element in value.docs) {
        listOfArchivedSessions.add(Sessions.fromJson(element.data()));
      }
      emit(AppArchivedCasesSuccState());
    }).catchError((error) {
      emit(AppArchivedCasesErrState(error.toString()));
    });
  }

  void deleteArchiveSession({required String id}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedSessions')
        .doc(id)
        .delete()
        .then((value) {
      getArchiveCase();
      emit(AppDeleteCasesSuccState());
    }).catchError((error) {
      emit(AppDeleteCasesErrState(error.toString()));
    });
  }

  void getSessions() {
    listOfSessions = [];
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      emit(AppLoadingGetSessionsState());
      for (QueryDocumentSnapshot userDoc in value.docs) {
        userDoc.reference
            .collection('Sessions')
            .orderBy('time', descending: true)
            .get()
            .then((value) {
          for (var element in value.docs) {
            listOfSessions.add(Sessions.fromJson(element.data()));
          }
          emit(AppGetSessionsSuccState());
        }).catchError((error) {
          emit(AppGetSessionsErrState(error.toString()));
        });
      }
    }).catchError((error) {
      emit(AppGetSessionsErrState(error.toString()));
    });
  }

  void getDrSessions() {
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      listOfDrSessions.clear();
      emit(AppLoadingGetSessionsState());
      for (QueryDocumentSnapshot userDoc in value.docs) {
        userDoc.reference
            .collection('Sessions')
            .where('uId', isEqualTo: uId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            listOfDrSessions.add(Sessions.fromJson(element.data()));
            // print(value.docs);
          }
          emit(AppGetSessionsSuccState());
        }).catchError((error) {
          emit(AppGetSessionsErrState(error.toString()));
        });
      }
    }).catchError((error) {
      emit(AppGetSessionsErrState(error.toString()));
    });
  }

  Future<void> sendMessage(
      {required String receivedId,
      required String time,
      required String message,
      context}) async {
    Messages model = Messages(
      messageId: 'ae',
      senderId: uId,
      receiverId: receivedId,
      time: time,
      message: message,
    );

    emit(AppLoadingMessagesState());

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Chats')
        .doc(receivedId)
        .collection('Messages')
        .add(model.toJson(context))
        .then((value) async {
      messagegId = value.id;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .collection('Chats')
          .doc(receivedId)
          .collection('Messages')
          .doc(value.id)
          .update({'messageId': messagegId});
      emit(AppSendMessagesSuccState());
    }).catchError((error) {
      emit(AppSendMessagesErrState(error.toString()));
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(receivedId)
        .collection('Chats')
        .doc(uId)
        .collection('Messages')
        .add(model.toJson(context))
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(receivedId)
          .collection('Chats')
          .doc(uId)
          .collection('Messages')
          .doc(value.id)
          .update({'messageId': messagegId});
      emit(AppSendMessagesSuccState());
    }).catchError((error) {
      emit(AppSendMessagesErrState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ChatsMenu')
        .doc(receivedId)
        .set({}).then((value) {
      emit(AppSendMessagesSuccState());
    }).catchError((error) {
      emit(AppSendMessagesErrState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receivedId)
        .collection('ChatsMenu')
        .doc(uId)
        .set({}).then((value) {
      emit(AppSendMessagesSuccState());
    }).catchError((error) {
      emit(AppSendMessagesErrState(error.toString()));
    });
  }

  Future<void> getMessages({required String receiverId, context}) async {
    emit(AppLoadingMessagesState());

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Chats')
        .doc(receiverId)
        .collection('Messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      listOfMessages = [];
      for (var element in event.docs) {
        listOfMessages.add(Messages.fromJson(element.data(), context));
      }
      print("GET MSG");
      emit(AppGetMessagesState());
    });
  }

  Future<void> deleteMyMessage({
    required String msgId,
    required String receiverId,
  }) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Chats')
        .doc(receiverId)
        .collection('Messages')
        .doc(msgId)
        .delete()
        .then((value) {
      emit(AppGetMessagesState());
    }).catchError((error) {
      emit(AppSendMessagesErrState(error.toString()));
    });
  }

  void deleteMessage({
    required String msgId,
    required String receiverId,
  }) {
    deleteMyMessage(msgId: msgId, receiverId: receiverId).then((value) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(receiverId)
          .collection('Chats')
          .doc(uId)
          .collection('Messages')
          .where('messageId', isEqualTo: msgId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          element.reference.delete();
        }
        emit(AppGetMessagesState());
      }).catchError((error) {
        emit(AppSendMessagesErrState(error.toString()));
      });
      emit(AppGetMessagesState());
    }).catchError((error) {
      emit(AppSendMessagesErrState(error.toString()));
    });
  }

  void getChats() {
    listOfUsers = [];
    emit(AppLoadingChatsState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ChatsMenu')
        .get()
        .then((value) {
      for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(element.id)
            .get()
            .then((value) {
          emit(AppLoadingChatsState());

          userModel = UserData.fromJson(value.data());
          listOfUsers.add(UserData.fromJson(value.data()));
          emit(AppGetChatsUsersSuccState());
        }).catchError((error) {
          print("have err $error");
          emit(AppGetChatsUsersErrState(error.toString()));
        });
      }
      emit(AppGetChatsUsersSuccState());
    }).catchError((error) {
      print("Error getting chats: $error");
      emit(AppGetChatsUsersErrState(error.toString()));
    });
  }

  Future<void> deleteChat({required String id}) async {
    emit(AppLoadingChatsState());
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .collection("ChatsMenu")
        .doc(id)
        .delete()
        .then((value) {
      emit(AppGetChatsUsersSuccState());
      FirebaseFirestore.instance
          .collection("Users")
          .doc(uId)
          .collection("Chats")
          .doc(id)
          .collection('Messages')
          .get()
          .then((value) {
        for (var element in value.docs) {
          element.reference.delete();
        }
        getChats();
        emit(AppGetChatsUsersSuccState());
      }).catchError((error) {
        print("Error delete chats: $error");
        emit(AppGetChatsUsersErrState(error.toString()));
      });
    }).catchError((error) {
      print("Error delete chats: $error");
      emit(AppGetChatsUsersErrState(error.toString()));
    });
  }

  Future<void> chgProfileImg() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      emit(AppChgProfileImageSuccState());
    } else {
      print("NO IMG");
      emit(AppChgProfileImageErrState());
    }
  }

  chgName() {
    name = !name;
    emit(AppChgState());
  }

  chgPhone() {
    phone = !phone;
    emit(AppChgState());
  }

  chgHospital() {
    hospital = !hospital;
    emit(AppChgState());
  }

  chgClinic() {
    clinic = !clinic;
    emit(AppChgState());
  }

  chgLink() {
    link = !link;
    emit(AppChgState());
  }

  chgGov() {
    gov = !gov;
    isEdit = !isEdit;
    emit(AppChgState());
  }

  void uploadProfileImg({
    String? name,
    String? phone,
    String? hospitalName,
    String? clinicAddress,
    String? volunteerGovernorate,
    String? volunteerCity,
    String? specialNeedGovernorate,
    String? specialNeedCity,
  }) {
    if (userType == "SpecialNeed") {
      FirebaseStorage.instance
          .ref()
          .child(
              'Users/SpecialNeeds/SpecialNeed/${spModel.email}/ProfileImages/${Uri.file(profileimage!.path).pathSegments.last}')
          .putFile(profileimage!)
          .then((val) {
        val.ref.getDownloadURL().then((value) {
          updateUserInfo(
            name: name,
            phone: phone,
            spProfileImage: value,
            specialNeedGovernorate: specialNeedGovernorate,
            specialNeedCity: specialNeedCity,
          );
          emit(AppUploadProfileImageSuccState());
        }).catchError((error) {
          print("up01 ERR ${error.toString()}");
          emit(AppUploadProfileImageErrState(error.toString()));
        });
      }).catchError((error) {
        print("up02 ERR ${error.toString()}");
        emit(AppUploadProfileImageErrState(error.toString()));
      });
    } else if (userType == "Volunteer") {
      FirebaseStorage.instance
          .ref()
          .child(
              'Users/Volunteers/${vModel.email}/ProfileImages/${Uri.file(profileimage!.path).pathSegments.last}')
          .putFile(profileimage!)
          .then((val) {
        val.ref.getDownloadURL().then((value) {
          updateUserInfo(
            name: name,
            phone: phone,
            vProfileImage: value,
            volunteerGovernorate: volunteerGovernorate,
            volunteerCity: volunteerCity,
          );
          emit(AppUploadProfileImageSuccState());
        }).catchError((error) {
          print("up01 ERR ${error.toString()}");
          emit(AppUploadProfileImageErrState(error.toString()));
        });
      }).catchError((error) {
        print("up02 ERR ${error.toString()}");
        emit(AppUploadProfileImageErrState(error.toString()));
      });
    } else if (userType == "Doctor") {
      FirebaseStorage.instance
          .ref()
          .child(
              'Users/Doctors/${drModel.email}/ProfileImages/${Uri.file(profileimage!.path).pathSegments.last}')
          .putFile(profileimage!)
          .then((val) {
        val.ref.getDownloadURL().then((value) {
          updateUserInfo(drProfileImage: value);
          emit(AppUploadProfileImageSuccState());
        }).catchError((error) {
          print("up01 ERR ${error.toString()}");
          emit(AppUploadProfileImageErrState(error.toString()));
        });
      }).catchError((error) {
        print("up02 ERR ${error.toString()}");
        emit(AppUploadProfileImageErrState(error.toString()));
      });
    }
  }

  void updateUserInfo({
    String? name,
    String? phone,
    String? hospitalName,
    String? clinicAddress,
    String? volunteerGovernorate,
    String? volunteerCity,
    String? specialNeedGovernorate,
    String? specialNeedCity,
    String? spProfileImage,
    String? vProfileImage,
    String? drProfileImage,
  }) {
    if (userType == "SpecialNeed") {
      emit(AppUpdateUserDataLoadingState());
      SpecialNeedData model = SpecialNeedData(
        uId: uId,
        userType: spModel.userType,
        name: name,
        email: spModel.email,
        phone: phone,
        msg: spModel.msg,
        isEmail: spModel.isEmail,
        profileImage: spProfileImage ?? spModel.profileImage,
        specialNeedNationalIdNumber: spModel.specialNeedNationalIdNumber,
        typeOfDisabiliy: spModel.typeOfDisabiliy,
        specialNeedGovernorate: specialNeedGovernorate,
        specialNeedCity: specialNeedCity,
        specialNeedNationalIdPicture: spModel.specialNeedNationalIdPicture,
        specialNeedPicture: spModel.specialNeedPicture,
        disablityCard: spModel.disablityCard,
        companionName: spModel.companionName,
        companionEmail: spModel.companionEmail,
        companionNationalIdNumber: spModel.companionNationalIdNumber,
        companionNationalIdPicture: spModel.companionNationalIdPicture,
        companionPicture: spModel.companionPicture,
      );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        getSpCasesUpdated();
        getArchivedCasesUpdated();
        print("specialneeds DATA SAVED");
        emit(AppUpdateUserDataSuccState());
      }).catchError((error) {
        print("specialneeds ERROR DATA ${error.toString()}");
        emit(AppUpdateUserDataErrState(error));
      });
    } else if (userType == "Volunteer") {
      emit(AppUpdateUserDataLoadingState());
      VolunteerData model = VolunteerData(
        uId: uId,
        userType: 'Volunteer',
        name: name,
        email: vModel.email,
        phone: phone,
        msg: vModel.msg,
        isEmail: vModel.isEmail,
        profileImage: vProfileImage ?? vModel.profileImage,
        volunteerNationalIdNumber: vModel.volunteerNationalIdNumber,
        volunteerHelp: vModel.volunteerHelp,
        volunteerGovernorate: volunteerGovernorate,
        volunteerCity: volunteerCity,
        volunteerNationalIdPicture: vModel.volunteerNationalIdPicture,
        volunteerPicture: vModel.volunteerPicture,
      );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        print("volunteers DATA SAVED");
        emit(AppUpdateUserDataSuccState());
      }).catchError((error) {
        print("volunteers ERROR DATA ${error.toString()}");
        emit(AppUpdateUserDataErrState(error));
      });
    } else if (userType == "Doctor") {
      emit(AppUpdateUserDataLoadingState());
      DoctorData model = DoctorData(
        uId: uId,
        userType: 'Doctor',
        name: drModel.name,
        email: drModel.email,
        phone: drModel.phone,
        msg: drModel.msg,
        isEmail: drModel.isEmail,
        profileImage: drProfileImage ?? drModel.profileImage,
        specially: drModel.specially,
        hospitalName: drModel.hospitalName,
        clinicAddress: drModel.clinicAddress,
        doctorNationalIdNumber: drModel.doctorNationalIdNumber,
        doctorNationalIdImage: drModel.doctorNationalIdImage,
        doctorPicture: drModel.doctorPicture,
        syndicateCardImage: drModel.syndicateCardImage,
      );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
        getSessionsUpdated();
        getArchivedSessionsUpdated();
        print("Doctors DATA SAVED");
        emit(AppUpdateUserDataSuccState());
      }).catchError((error) {
        print("ERROR Doctors DATA ${error.toString()}");
        emit(AppUpdateUserDataErrState(error));
      });
    }
  }

  void getSessionsUpdated() {
    listOfSessions.clear();
    emit(AppLoadingGetSessionsState());
    getUserData();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Sessions')
        .get()
        .then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data['profileImage'] = drModel.profileImage;

        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('Sessions')
            .doc(element.id)
            .update(data)
            .then((val) {
          listOfSessions.add(Sessions.fromJson(element.data()));
          getSessions();
          print("object");
          emit(AppGetSessionsSuccState());
        }).catchError((error) {
          print("Error updating Sessions document: ${error.toString()}");
          emit(AppGetSessionsErrState(error.toString()));
        });
      }
      emit(AppGetSessionsSuccState());
    }).catchError((error) {
      emit(AppGetSessionsErrState(error.toString()));
    });
  }

  void getSpCasesUpdated() {
    listOfSpCases.clear();
    emit(AppLoadingGetSpCasesState());
    getUserData();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Cases')
        .get()
        .then((value) {
      for (var element in value.docs) {
        // Add the document ID to the data for updating
        Map<String, dynamic> data = element.data();
        data['profileImage'] = spModel.profileImage;
        data['name'] = spModel.name;

        // Update the document with the modified data
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('Cases')
            .doc(element.id)
            .update(data)
            .then((val) {
          listOfSpCases.add(Cases.fromJson(element.data()));
          getSpCases();
          emit(AppGetSpCasesSuccState());
        }).catchError((error) {
          print("Error updating Cases documents: ${error.toString()}");
          emit(AppGetSpCasesErrState(error.toString()));
        });
      }
      emit(AppGetSpCasesSuccState());
    }).catchError((error) {
      emit(AppGetSpCasesErrState(error.toString()));
    });
  }

  void getArchivedSessionsUpdated() {
    listOfArchivedSessions.clear();
    emit(AppLoadingGetSessionsState());
    getUserData();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedSessions')
        .get()
        .then((value) {
      for (var element in value.docs) {
        // Add the document ID to the data for updating
        Map<String, dynamic> data = element.data();
        data['profileImage'] = drModel.profileImage;

        // Update the document with the modified data
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('ArchivedSessions')
            .doc(element.id)
            .update(data)
            .then((val) {
          listOfArchivedSessions.add(Sessions.fromJson(element.data()));
          getSessions();
          print("object");
          emit(AppGetSessionsSuccState());
        }).catchError((error) {
          print("Error updating Sessions document: ${error.toString()}");
          emit(AppGetSessionsErrState(error.toString()));
        });
      }
      emit(AppGetSessionsSuccState());
    }).catchError((error) {
      emit(AppGetSessionsErrState(error.toString()));
    });
  }

  void getArchivedCasesUpdated() {
    listOfArchivedCases.clear();
    emit(AppLoadingGetSpCasesState());
    getUserData();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('ArchivedCases')
        .get()
        .then((value) {
      for (var element in value.docs) {
        // Add the document ID to the data for updating
        Map<String, dynamic> data = element.data();
        data['profileImage'] = spModel.profileImage;
        data['name'] = spModel.name;

        // Update the document with the modified data
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uId)
            .collection('ArchivedCases')
            .doc(element.id)
            .update(data)
            .then((val) {
          listOfArchivedCases.add(Cases.fromJson(element.data()));
          getSpCases();
          emit(AppGetSpCasesSuccState());
        }).catchError((error) {
          print("Error updating Cases documents: ${error.toString()}");
          emit(AppGetSpCasesErrState(error.toString()));
        });
      }
      emit(AppGetSpCasesSuccState());
    }).catchError((error) {
      emit(AppGetSpCasesErrState(error.toString()));
    });
  }

  void updateUserData({
    String? name,
    String? phone,
    String? hospitalName,
    String? clinicAddress,
    String? volunteerGovernorate,
    String? volunteerCity,
    String? specialNeedGovernorate,
    String? specialNeedCity,
  }) {
    if (userType == "SpecialNeed") {
      if (profileimage != null) {
        uploadProfileImg(
          name: name,
          phone: phone,
          specialNeedGovernorate: specialNeedGovernorate,
          specialNeedCity: specialNeedCity,
        );
      } else {
        updateUserInfo(
          name: name,
          phone: phone,
          specialNeedGovernorate: specialNeedGovernorate,
          specialNeedCity: specialNeedCity,
        );
      }
    } else if (userType == "Volunteer") {
      if (profileimage != null) {
        uploadProfileImg(
          name: name,
          phone: phone,
          volunteerGovernorate: volunteerGovernorate,
          volunteerCity: volunteerCity,
        );
      } else {
        updateUserInfo(
          name: name,
          phone: phone,
          volunteerGovernorate: volunteerGovernorate,
          volunteerCity: volunteerCity,
        );
      }
    } else if (userType == "Doctor") {
      if (profileimage != null) {
        uploadProfileImg();
      } else {
        updateUserInfo();
      }
    }
  }

  String encryptMessage(String messageToEncrypt) {
    final key = encrypt.Key.fromUtf8("a5f6b3de4g7h8ij9k2lm3nopqr0stuv1");
    final iv = encrypt.IV.fromUtf8("3xy8zw6v1n0pqrs2");
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(messageToEncrypt, iv: iv);
    encryptedMessage = encrypted.base64;
    decryptedMessage = '';
    emit(AppEncryptMessageState());

    return encryptedMessage;
  }

  String decryptMessage(String messageToDecrypt) {
    final key = encrypt.Key.fromUtf8("a5f6b3de4g7h8ij9k2lm3nopqr0stuv1");
    final iv = encrypt.IV.fromUtf8("3xy8zw6v1n0pqrs2");
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(messageToDecrypt, iv: iv);
    decryptedMessage = decrypted;
    emit(AppDecryptMessageState());

    return decryptedMessage;
  }

  void enableFingerPrint(bool value) async {
    if (value) {
      bool isFingerPrintEnabled = await finger.isFingerEnable();
      if (isFingerPrintEnabled) {
        await CacheHelper.saveData(
                key: "fingerprint", val: "FingerPrintEnabled")
            .then((value) {
          fPrint = CacheHelper.getData(key: 'fingerprint');
          emit(AppFingerPrintState());
        });
        msg(msg: "Finger Print Enabled", bg: ToastStates.SUCC);
      }
    } else {
      await CacheHelper.clearData(key: "fingerprint")
          .then((value) => fPrint = "");
    }
    isSwitchChecked = value;
    emit(AppFingerPrintState());
  }

  void fingerPrintLogin(context) async {
    bool isFingerPrintEnabled = await finger.isFingerEnable();
    if (isFingerPrintEnabled) {
      bool isAuth = await finger.isAuth("login using finger print");
      if (isAuth) {
        if (uId != null) {
          pgx(context, const Bridgelt());
          // getUserData();
        }
      }
    }
  }
// String aesKey = generateAesKey();
//
//   String generateAesKey() {
//   final random = Random.secure();
//   final keyBytes = Uint8List(32); // 256 bits
//   for (var i = 0; i < keyBytes.length; i++) {
//     keyBytes[i] = random.nextInt(256);
//   }
//   return base64Url.encode(keyBytes);
// }
}
