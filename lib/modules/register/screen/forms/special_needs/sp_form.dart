import 'package:bridgelt/modules/register/cubit/register_cubit.dart';
import 'package:bridgelt/modules/register/cubit/register_states.dart';
import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

var ctrlSpNID = TextEditingController();
var ctrlCName = TextEditingController();
var ctrlCEMail = TextEditingController();
var ctrlCNID = TextEditingController();
var formkey = GlobalKey<FormState>();

Widget spForm(context) {
  return BlocConsumer<RegisterCubit, RegisterStates>(
    listener: (context, state) {
      if (state is RegisterSuccState) {
        pgx(context, const Login());
        msg(msg: "Successful Registeration", bg: ToastStates.SUCC);
        RegisterCubit.get(context).clearBtn();
      }
    },
    builder: (context, state) {
      var cubitForm = RegisterCubit.get(context);
      return Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: txt(
                    context: context,
                    txt: "Hey ${cubitForm.ctrlUName.text} ^_^",
                    bd: true,
                    sz: 23,
                    spc: 1,
                  ),
                ),
                const SizedBox(height: 13),
                tff(
                  txt: "National ID Number",
                  icon: Icons.add_card_outlined,
                  ctrl: ctrlSpNID,
                  type: TextInputType.number,
                  mx: 14,
                  vld: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Your National ID Number';
                    }
                    if (val.length != 14) {
                      return 'National ID Number must be 14 numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: txt(
                        context: context,
                        txt: "Type of Disability",
                        sz: 16,
                      ),
                    ),
                    DropdownButton<String>(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      value: cubitForm.selectedDisability,
                      onChanged: (String? newValue) {
                        cubitForm.selectedDisability = newValue!;
                        cubitForm.dropdown(newValue);
                      },
                      items: <String>[
                        "Visual Impairment",
                        "Hearing Impairment",
                        "Mobility Impairment",
                        "Intellectual Impairment",
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: txt(
                        context: context,
                        sz: 16,
                        txt: "Governorate",
                      ),
                    ),
                    DropdownButton<String>(
                      value: cubitForm.selectedGov,
                      onChanged: (String? newValue) {
                        cubitForm.govChoise(newValue);
                      },
                      items: governorate.keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: txt(
                        context: context,
                        sz: 16,
                        txt: "City",
                      ),
                    ),
                    DropdownButton<String>(
                      value: cubitForm.selectedCity,
                      onChanged: (String? newValue) {
                        cubitForm.selectedCity = newValue!;
                        cubitForm.dropdown(newValue);
                      },
                      items: governorate[cubitForm.selectedGov]!
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: txt(
                        context: context,
                        txt: 'National ID',
                        sz: 16,
                        spc: 0,
                        st: false,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: txt(
                        context: context,
                        txt: 'Face',
                        sz: 16,
                        spc: 0,
                        st: false,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: txt(
                        context: context,
                        txt: 'Disability Card',
                        sz: 16,
                        spc: 0,
                        st: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //NIDSp
                        fun: () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              cubitForm.nIdSpPicker(
                                                  ImageSource.camera);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                              cubitForm.nIdSpPicker(
                                                  ImageSource.gallery);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .photo_library_outlined,
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
                        },
                        isTxt: true,
                        text: cubitForm.nIdSpImageName ?? 'UPLOAD',
                        sz: cubitForm.nIdSpImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //PicSp
                        fun: () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              cubitForm
                                                  .picSpPicker(
                                                      ImageSource.camera)
                                                  .then((value) => cubitForm
                                                      .detectFaces(cubitForm
                                                          .picSpImage!));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                              cubitForm
                                                  .picSpPicker(
                                                      ImageSource.gallery)
                                                  .then((value) => cubitForm
                                                      .detectFaces(cubitForm
                                                          .picSpImage!));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .photo_library_outlined,
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
                        },
                        isTxt: true,
                        text: cubitForm.picSpImageName ?? 'UPLOAD',
                        sz: cubitForm.picSpImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //CardSp
                        fun: () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              cubitForm.cardSpPicker(
                                                  ImageSource.camera);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                              cubitForm.cardSpPicker(
                                                  ImageSource.gallery);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .photo_library_outlined,
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
                        },
                        text: cubitForm.cardSpImageName ?? 'UPLOAD',
                        sz: cubitForm.cardSpImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                Align(
                  alignment: Alignment.centerLeft,
                  child: txt(
                    context: context,
                    txt: "Your Companion",
                    bd: true,
                    sz: 23,
                  ),
                ),
                const SizedBox(height: 13),
                tff(
                  txt: "Full Name",
                  icon: Icons.person_2_outlined,
                  ctrl: ctrlCName,
                  type: TextInputType.name,
                  vld: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Your Companion Full Name';
                    }
                    if (val.contains(RegExp(r'[0-9]'))) {
                      return "UserName mustn't contain at least one digit";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 13),
                tff(
                  txt: "E-Mail",
                  icon: Icons.email_outlined,
                  ctrl: ctrlCEMail,
                  type: TextInputType.emailAddress,
                  vld: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Your Companion E-Mail';
                    }
                    if (!EmailValidator.validate(val)) {
                      return 'Please enter a valid email';
                    }
                    if (!val.contains('@')) {
                      return 'Email must contain @ symbol';
                    }
                    if (!val.contains('.')) {
                      return 'Email must contain domain (e.g., .com, .net)';
                    }
                    if (val.startsWith('.') || val.endsWith('.')) {
                      return 'Email cannot start or end with a dot';
                    }
                    if (val.split('@').length != 2) {
                      return 'Email must contain only one @ symbol';
                    }
                    if (val.contains(' ')) {
                      return 'Email cannot contain spaces';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 13),
                tff(
                  txt: "National ID Number",
                  icon: Icons.add_card_outlined,
                  ctrl: ctrlCNID,
                  type: TextInputType.number,
                  mx: 14,
                  vld: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Your Companion National ID Number';
                    }
                    if (val.length != 14) {
                      return 'Companion National ID Number must be 14 numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: txt(
                        context: context,
                        txt: 'National ID',
                        sz: 16,
                        spc: 0,
                        st: false,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: txt(
                        context: context,
                        txt: 'Picture',
                        sz: 16,
                        spc: 0,
                        st: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //NIDCSp
                        fun: () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              cubitForm.nIdCSpPicker(
                                                  ImageSource.camera);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                              cubitForm.nIdCSpPicker(
                                                  ImageSource.gallery);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .photo_library_outlined,
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
                        },
                        isTxt: true,
                        text: cubitForm.nIdCSpImageName ?? 'UPLOAD',
                        sz: cubitForm.nIdCSpImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //PicCSp
                        fun: () {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              cubitForm
                                                  .picCSpPicker(
                                                      ImageSource.camera)
                                                  .then((value) => cubitForm
                                                      .detectFaces(cubitForm
                                                          .picCSpImage!));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                              cubitForm
                                                  .picCSpPicker(
                                                      ImageSource.gallery)
                                                  .then((value) => cubitForm
                                                      .detectFace(cubitForm
                                                          .picCSpImage!));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .photo_library_outlined,
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
                        },
                        isTxt: true,
                        text: cubitForm.picCSpImageName ?? 'UPLOAD',
                        sz: cubitForm.picCSpImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                cubitForm.isSpPics
                    ? CircularProgressIndicator(color: bg)
                    : Visibility(
                        visible: cubitForm.nIdSpImage != null &&
                            cubitForm.picSpImage != null &&
                            cubitForm.cardSpImage != null &&
                            cubitForm.nIdCSpImage != null &&
                            cubitForm.picCSpImage != null,
                        child: btn(
                          fun: () {
                            if (formkey.currentState!.validate()) {
                              if (cubitForm.faces.length == 1) {
                                if (cubitForm.face.length == 1) {
                                  cubitForm.isSpPics = true;
                                  cubitForm.uploadNationaIdSpImg(
                                    name: cubitForm.ctrlUName.text,
                                    email: cubitForm.ctrlEMail.text,
                                    pass: cubitForm.ctrlPass.text,
                                    phone: cubitForm.ctrlPhone.text,
                                    specialNeedNationalIdNumber: ctrlSpNID.text,
                                    typeOfDisabiliy:
                                        cubitForm.selectedDisability,
                                    specialNeedGovernorate:
                                        cubitForm.selectedGov,
                                    specialNeedCity: cubitForm.selectedCity,
                                    companionName: ctrlCName.text,
                                    companionEmail: ctrlCEMail.text,
                                    companionNationalIdNumber: ctrlCNID.text,
                                  );
                                } else {
                                  msg(
                                      msg:
                                          'Take a valid picture for your companion',
                                      bg: ToastStates.ERR);
                                }
                              } else {
                                msg(
                                    msg: 'Take a valid picture for you',
                                    bg: ToastStates.ERR);
                              }
                            }
                          },
                          isTxt: true,
                          text: 'Complete',
                          clr: bg,
                          rd: 69,
                          sz: 23,
                          up: false,
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
