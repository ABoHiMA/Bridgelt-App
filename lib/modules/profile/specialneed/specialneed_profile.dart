// ignore_for_file: non_constant_identifier_names
import 'package:bridgelt/models/cases_model.dart';
import 'package:bridgelt/modules/profile/specialneed/sp_edit.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialNeedProfile extends StatelessWidget {
  const SpecialNeedProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              spProfile(context),
              const SizedBox(height: 9),
              const Divider(),
              const SizedBox(height: 29),
              cubitApp.listOfSpCases.isNotEmpty
                  ? txt(
                      context: context,
                      txt: "My Cases",
                      bd: true,
                      sz: 29,
                      isClr: true,
                    )
                  : const SizedBox(),
              const SizedBox(height: 9),
              ConditionalBuilder(
                condition: state is! AppLoadingGetSpCasesState,
                builder: (context) => cubitApp.listOfSpCases.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => spCases(
                            context, index, cubitApp.listOfSpCases[index]),
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: cubitApp.listOfSpCases.length,
                      )
                    : Center(
                        child: txt(
                          context: context,
                          txt: "No Cases Yet",
                          bd: true,
                          isClr: true,
                          sz: 29,
                          st: false,
                        ),
                      ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator(color: bg)),
              ),
              const SizedBox(height: 9),
            ],
          ),
        );
      },
    );
  }
}

Widget spProfile(
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
            offset: const Offset(0, 3), // changes position of shadow
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
                    NetworkImage(AppCubit.get(context).spModel.profileImage!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                children: [
                  txt(
                    context: context,
                    txt: AppCubit.get(context).spModel.name!,
                    clr: wt,
                    isClr: true,
                    st: false,
                    sz: 26,
                  ),
                  const SizedBox(height: 10),
                  txt(
                    context: context,
                    txt:
                        '${AppCubit.get(context).spModel.userType} - ${AppCubit.get(context).spModel.typeOfDisabiliy}',
                    clr: wt,
                    isClr: true,
                    sz: 17,
                    bd: true,
                    st: false,
                  ),
                  const SizedBox(height: 10),
                  txt(
                    context: context,
                    txt: 'Phone: ${AppCubit.get(context).spModel.phone}',
                    clr: wt,
                    isClr: true,
                    st: false,
                    sz: 16,
                  ),
                  const SizedBox(height: 10),
                  txt(
                    context: context,
                    txt:
                        "From: ${AppCubit.get(context).spModel.specialNeedGovernorate}, ${AppCubit.get(context).spModel.specialNeedCity}",
                    clr: wt,
                    isClr: true,
                    st: false,
                    sz: 16,
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
                    pgn(context, const EditSpecialNeedProfile());
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

Widget spCases(
  context,
  index,
  Cases model,
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
                          Row(
                            children: [
                              txt(
                                txt: model.name!,
                                context: context,
                                bd: true,
                              ),
                              const SizedBox(width: 7),
                              // const Icon(
                              //   Icons.verified_outlined,
                              //   // color: Colors.blueAccent,
                              //   size: 19,
                              // ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          txt(
                            context: context,
                            txt: model.time!,
                            sz: 13,
                            isClr: true,
                          ),
                          txt(
                            context: context,
                            txt: "${model.city!} - ${model.gov!}",
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
              const SizedBox(height: 9),
              txt(
                context: context,
                txt: model.text!,
                sz: 16,
                spc: 1,
              ),
              // const SizedBox(height: 18),
              // const Image(
              //   image: NetworkImage(
              //     'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=740&t=st=1700490559~exp=1700491159~hmac=0a3cc67a1ffce1192bdf53b5e974fd4340173b31eed80059600ea57ea8667da3',
              //   ),
              //   width: double.infinity,
              //   height: 169,
              // ),

              const Divider(),
              const SizedBox(height: 7),
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
                                  txt: "You will delete this case"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .deleteCase(id: model.caseId!);
                                    Navigator.of(context).pop();
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
                      isTxt: true,
                      up: false,
                      text: "Delete Case",
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
                                  txt: "You will archive this case"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .archiveCase(id: model.caseId!);
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
                      text: "Archive Case",
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

