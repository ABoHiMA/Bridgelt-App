// ignore_for_file: non_constant_identifier_names
import 'package:bridgelt/models/session_model.dart';
import 'package:bridgelt/modules/profile/doctor/dr_edit.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppDeleteSessionSuccState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              drProfile(context),
              const SizedBox(height: 9),
              const Divider(),
              const SizedBox(height: 29),
              cubitApp.listOfDrSessions.isNotEmpty
                  ? txt(
                      context: context,
                      txt: "My Sessions",
                      bd: true,
                      sz: 29,
                      isClr: true,
                      st: false,
                    )
                  : const SizedBox(),
              const SizedBox(height: 9),
              ConditionalBuilder(
                condition: state is! AppLoadingGetSessionsState,
                builder: (context) => cubitApp.listOfDrSessions.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => drSession(
                            context, index, cubitApp.listOfDrSessions[index]),
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: cubitApp.listOfDrSessions.length,
                      )
                    : Center(
                        child: txt(
                          context: context,
                          txt: "No Sessions Yet",
                          bd: true,
                          isClr: true,
                          sz: 29,
                          st: false,
                        ),
                      ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator(color: bg)),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget drProfile(
  context,
) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 103, 85, 183),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage:
                    NetworkImage(AppCubit.get(context).drModel.profileImage!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                children: [
                  txt(
                    context: context,
                    txt: AppCubit.get(context).drModel.name!,
                    clr: wt,
                    isClr: true,
                    sz: 26,
                    bd: true,
                    st: false,
                  ),
                  const SizedBox(height: 10),
                  txt(
                    context: context,
                    txt:
                        "$userType - ${AppCubit.get(context).drModel.specially}",
                    clr: wt,
                    isClr: true,
                    sz: 20,
                    st: false,
                  ),
                  const SizedBox(height: 10),
                  txt(
                    context: context,
                    txt: 'Phone: ${AppCubit.get(context).drModel.phone}',
                    clr: wt,
                    isClr: true,
                    sz: 16,
                    st: false,
                  ),
                  const SizedBox(height: 10),
                  txt(
                    context: context,
                    txt:
                        "Hospital: ${AppCubit.get(context).drModel.hospitalName}",
                    clr: wt,
                    isClr: true,
                    sz: 16,
                    st: false,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 35,
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    pgn(context, const EditDoctorProfile());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      txt(
                        context: context,
                        txt: "Edit Profile",
                        isClr: true,
                        clr: bg,
                        sz: 17,
                        bd: true,
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.edit_outlined,
                        color: bg,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget drSession(
  context,
  index,
  Sessions model,
) =>
    Padding(
      padding: const EdgeInsets.all(6.18),
      child: Card(
        surfaceTintColor: bg,
        shadowColor: bg,
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          margin: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          model.profileImage!,
                        ),
                        radius: 29,
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txt(
                            txt: model.name!,
                            context: context,
                            bd: true,
                          ),
                          const SizedBox(height: 3),
                          txt(
                            context: context,
                            txt:
                                "$userType - ${AppCubit.get(context).drModel.specially}",
                            sz: 13,
                            isClr: true,
                          ),
                          const SizedBox(height: 6),
                          txt(
                            context: context,
                            txt: model.time!,
                            sz: 13,
                            isClr: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 3),
              const Divider(),
              // const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: txt(
                  context: context,
                  txt: model.text!,
                  sz: 16,
                  spc: 1,
                ),
              ),
              // const SizedBox(height: 18),
              // const Image(
              //   image: NetworkImage(
              //     'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=740&t=st=1700490559~exp=1700491159~hmac=0a3cc67a1ffce1192bdf53b5e974fd4340173b31eed80059600ea57ea8667da3',
              //   ),
              //   width: double.infinity,
              //   height: 169,
              // ),
              // const SizedBox(height: 13),
              const Divider(),
              const SizedBox(height: 7),

              model.link != "No Link Found"
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: btn(
                        fun: () {
                          if (model.link != "No Link Found") {
                            url(link: model.link!);
                          }
                        },
                        isTxt: true,
                        text: "Link of session",
                        clr: Colors.cyan,
                        sz: 14,
                      ),
                    )
                  : const SizedBox(),
              Row(
                children: [
                  Expanded(
                    child: btn(
                      fun: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: txt(
                                  context: context, txt: "Warning", bd: true),
                              content: txt(
                                  context: context,
                                  txt: "You will delete this Sessions"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .deleteSession(id: model.sessionId!);
                                  },
                                  child: const Text("Delete"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      up: false,
                      isTxt: true,
                      text: "Delete",
                      clr: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: btn(
                      fun: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: txt(
                                  context: context, txt: "Warning", bd: true),
                              content: txt(
                                  context: context,
                                  txt: "You will archive this Session"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .archiveSession(id: model.sessionId!);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Archive"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      isTxt: true,
                      up: false,
                      text: "Archive",
                      clr: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );

