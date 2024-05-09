import 'package:bridgelt/models/cases_model.dart';
import 'package:bridgelt/modules/messages/screen/other_messages_screen.dart';
import 'package:bridgelt/modules/profile/others/sp_others.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppGetOthersUserDataSuccState) {
          pgn(context, const OthersSpecialNeedProfile());
        }

        if (state is AppGetOthersUserChatSuccState) {
          AppCubit.get(context)
              .getMessages(receiverId: AppCubit.get(context).otherUId!,context: context);
          pgn(
            context,
            const OtherMessagesScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        return ConditionalBuilder(
          condition: state is! AppLoadingGetCasesState,
          builder: (context) => cubitApp.listOfDrCases.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => cubitApp.isFilter
                      ? spCases(
                          context,
                          index,
                          cubitApp.listOfFilteredDrCases[index],
                        )
                      : spCases(
                          context,
                          index,
                          cubitApp.listOfDrCases[index],
                        ),
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: cubitApp.isFilter
                      ? cubitApp.listOfFilteredDrCases.length
                      : cubitApp.listOfDrCases.length,
                )
              : Center(
                  child: txt(
                    context: context,
                    txt: "No Cases Yet",
                    bd: true,
                    isClr: true,
                    sz: 29,
                  ),
                ),
          fallback: (context) =>
              Center(child: CircularProgressIndicator(color: bg)),
        );
      },
    );
  }
}

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
                          Container(
                            height: 30,
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                              style: const ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero),
                              ),
                              onPressed: () {
                                // print("===========${model.uId}");
                                AppCubit.get(context)
                                    .getOtherUserData(uid: model.uId!);
                              },
                              child: txt(
                                txt: model.name!,
                                context: context,
                                bd: true,
                              ),
                            ),
                          ),
                          txt(
                            context: context,
                            txt: model.typeOfDisabiliy!,
                            sz: 17,
                            isClr: true,
                          ),
                          const SizedBox(height: 3),
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
              model.isMsg!
                  ? Center(
                      child: txt(
                        context: context,
                        txt: "Messaged",
                        bd: true,
                        isClr: true,
                        clr: bg,
                        sz: 23,
                      ),
                    )
                  : btn(
                      fun: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: txt(
                                  context: context, txt: "Warning", bd: true),
                              content: txt(
                                context: context,
                                txt: "You will message that",
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .getSpecialNeedCaseChat(
                                            otheruid: model.uId!);
                                    // AppCubit.get(context).msgBtn(caseId: model.caseId!);
                                  },
                                  child: const Text("Message"),
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
                      text: "Message",
                      clr: bg,
                    ),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
