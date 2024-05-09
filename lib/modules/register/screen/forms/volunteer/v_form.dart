import 'package:bridgelt/modules/register/cubit/register_cubit.dart';
import 'package:bridgelt/modules/register/cubit/register_states.dart';
import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

var ctrlVNID = TextEditingController();
var formkey = GlobalKey<FormState>();
String checkedItems = '';

Widget vForm(context) {
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
                    txt: "Hey ${cubitForm.ctrlUName.text}",
                    bd: true,
                    sz: 23,
                    spc: 1,
                  ),
                ),
                const SizedBox(height: 13),
                tff(
                  txt: "National ID Number",
                  icon: Icons.add_card_outlined,
                  ctrl: ctrlVNID,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    txt(
                      context: context,
                      txt: "You 'll Help",
                      sz: 16,
                    ),
                    const Expanded(child: SizedBox(width: 7)),
                    ElevatedButton(
                      onPressed: () {
                        showPopupMenu(context);
                      },
                      child: const Text('Choose'),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
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
                        txt: 'National ID Picture',
                        sz: 16,
                        spc: 0,
                        st: false,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: txt(
                        context: context,
                        txt: 'Face Picture',
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
                        //NIDV
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
                                              cubitForm.nIdVPicker(
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
                                              cubitForm.nIdVPicker(
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
                        text: cubitForm.nIdVImageName ?? 'UPLOAD',
                        sz: cubitForm.nIdVImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: btn(
                        //PicV
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
                                                  .picVPicker(
                                                      ImageSource.camera)
                                                  .then((value) => cubitForm
                                                      .detectFaces(cubitForm
                                                          .picVImage!));
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
                                                  .picVPicker(
                                                      ImageSource.gallery)
                                                  .then((value) => cubitForm
                                                      .detectFaces(cubitForm
                                                          .picVImage!));
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
                        text: cubitForm.picVImageName ?? 'UPLOAD',
                        sz: cubitForm.picVImageName == null ? 16 : 9,
                        ht: 36,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                cubitForm.isVPics
                    ? CircularProgressIndicator(color: bg)
                    : Visibility(
                        visible: cubitForm.nIdVImage != null &&
                            cubitForm.picVImage != null,
                        child: btn(
                          fun: () {
                            if (formkey.currentState!.validate()) {
                              if (cubitForm.faces.length == 1) {
                                cubitForm.isVPics = true;
                                cubitForm.uploadNationaIdVImg(
                                  name: cubitForm.ctrlUName.text,
                                  email: cubitForm.ctrlEMail.text,
                                  pass: cubitForm.ctrlPass.text,
                                  phone: cubitForm.ctrlPhone.text,
                                  volunteerNationalIdNumber: ctrlVNID.text,
                                  volunteerHelp: checkedItems,
                                  volunteerGovernorate: cubitForm.selectedGov,
                                  volunteerCity: cubitForm.selectedCity,
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

/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////

void showPopupMenu(BuildContext context) async {
  await showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(50, 50, 50, 50),
    items: [
      const PopupMenuItem(
        child: MyCheckboxList(),
      ),
    ],
    elevation: 8.0,
  );
}

class MyCheckboxList extends StatefulWidget {
  const MyCheckboxList({super.key});

  @override
  MyCheckboxListState createState() => MyCheckboxListState();
}

class MyCheckboxListState extends State<MyCheckboxList> {
  bool visualImpairment = false;
  bool hearingImpairment = false;
  bool mobilityImpairment = false;
  bool intellectualImpairment = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Visual Impairment'),
          value: visualImpairment,
          onChanged: (bool? value) {
            setState(() {
              visualImpairment = value!;
            });
            updateCheckedItems();
          },
        ),
        CheckboxListTile(
          title: const Text('Hearing Impairment'),
          value: hearingImpairment,
          onChanged: (bool? value) {
            setState(() {
              hearingImpairment = value!;
            });
            updateCheckedItems();
          },
        ),
        CheckboxListTile(
          title: const Text('Mobility Impairment'),
          value: mobilityImpairment,
          onChanged: (bool? value) {
            setState(() {
              mobilityImpairment = value!;
            });
            updateCheckedItems();
          },
        ),
        CheckboxListTile(
          title: const Text('Intellectual Impairment'),
          value: intellectualImpairment,
          onChanged: (bool? value) {
            setState(() {
              intellectualImpairment = value!;
            });
            updateCheckedItems();
          },
        ),
        Text(
          checkedItems.isNotEmpty ? checkedItems : 'None',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void updateCheckedItems() {
    setState(() {
      checkedItems = '';
      if (visualImpairment) checkedItems += 'Visual Impairment\n';
      if (hearingImpairment) checkedItems += 'Hearing Impairment\n';
      if (mobilityImpairment) checkedItems += 'Mobility Impairment\n';
      if (intellectualImpairment) checkedItems += 'Intellectual Impairment\n';
    });
  }
}
