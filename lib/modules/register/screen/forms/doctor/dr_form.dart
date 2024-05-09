import 'package:bridgelt/modules/register/cubit/register_cubit.dart';
import 'package:bridgelt/modules/register/cubit/register_states.dart';
import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

var ctrlHospitalName = TextEditingController();
var ctrlClinicAddress = TextEditingController();
var ctrlDrNID = TextEditingController();
var formkey = GlobalKey<FormState>();

Widget drForm(context) {
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
                    txt: "Hey Dr. ${cubitForm.ctrlUName.text}",
                    bd: true,
                    sz: 23,
                    spc: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    txt(
                      context: context,
                      txt: 'Specialty',
                    ),
                    DropdownButton<String>(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      value: cubitForm.selectedSpecialty,
                      onChanged: (String? newValue) {
                        cubitForm.selectedSpecialty = newValue!;
                        cubitForm.dropdown(newValue);
                      },
                      items: <String>[
                        "Psychiatrist",
                        "Neurologist",
                        "Physiotherapist",
                        "Speech Therapist",
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
                const SizedBox(height: 7),
                tff(
                  txt: "Hospital Name",
                  icon: Icons.local_hospital_outlined,
                  ctrl: ctrlHospitalName,
                  type: TextInputType.name,
                  vld: (val) {
                    if (val!.isEmpty) {
                      return 'Enter The Hospital Name';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 13),
                tff(
                  txt: "Clinic Address",
                  icon: Icons.location_on,
                  ctrl: ctrlClinicAddress,
                  type: TextInputType.streetAddress,
                  vld: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Your Clinic Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 13),
                tff(
                  txt: "National ID Number",
                  icon: Icons.add_card_outlined,
                  ctrl: ctrlDrNID,
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
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: txt(
                        context: context,
                        txt: 'Syndicate Card',
                        sz: 16,
                        spc: 0,
                        st: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //NId
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
                                              cubitForm.nIdDrPicker(
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
                                              cubitForm.nIdDrPicker(
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
                        text: cubitForm.nIdDrImageName ?? 'UPLOAD',
                        sz: cubitForm.nIdDrImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //PicDr
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
                                                  .picDrPicker(
                                                      ImageSource.camera)
                                                  .then((value) => cubitForm
                                                      .detectFaces(cubitForm
                                                          .picDrImage!));
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
                                                  .picDrPicker(
                                                      ImageSource.gallery)
                                                  .then((value) => cubitForm
                                                      .detectFaces(cubitForm
                                                          .picDrImage!));
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
                        text: cubitForm.picDrImageName ?? 'UPLOAD',
                        sz: cubitForm.picDrImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //CardDr
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
                                              cubitForm.cardDrPicker(
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
                                              cubitForm.cardDrPicker(
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
                        text: cubitForm.cardDrImageName ?? 'UPLOAD',
                        sz: cubitForm.cardDrImage == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                cubitForm.isDrPics
                    ? CircularProgressIndicator(color: bg)
                    : Visibility(
                        visible: cubitForm.nIdDrImage != null &&
                            cubitForm.picDrImage != null &&
                            cubitForm.cardDrImage != null,
                        child: btn(
                          fun: () {
                            if (formkey.currentState!.validate()) {
                              if (cubitForm.faces.length == 1) {
                                cubitForm.isDrPics = true;
                                cubitForm.uploadNationaIdDrImg(
                                  name: cubitForm.ctrlUName.text,
                                  email: cubitForm.ctrlEMail.text,
                                  pass: cubitForm.ctrlPass.text,
                                  phone: cubitForm.ctrlPhone.text,
                                  specially: cubitForm.selectedSpecialty,
                                  hospitalName: ctrlHospitalName.text,
                                  clinicAddress: ctrlClinicAddress.text,
                                  doctorNationalIdNumber: ctrlDrNID.text,
                                );
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
