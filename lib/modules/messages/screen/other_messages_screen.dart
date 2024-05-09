import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/models/messages_model.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherMessagesScreen extends StatelessWidget {
  const OtherMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var ctrlMsg = TextEditingController();
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(
            receiverId: AppCubit.get(context).otherUId!, context: context);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubitApp = AppCubit.get(context);
            cubitApp.ctrlMsg.addListener(() {
              cubitApp.msgFieldListener();
            });
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                leading: IconButton(
                  onPressed: () {
                    pgx(context, const Bridgelt());
                    index = 0;
                    if (userType == "Volunteer") {
                      cubitApp.listOfVCases.clear();
                      cubitApp.isFilter
                          ? cubitApp.getFilteredVCases()
                          : cubitApp.getVCases();
                    } else if (userType == "SpecialNeed") {
                      cubitApp.listOfSessions.clear();
                      cubitApp.getSessions();
                    } else if (userType == "Doctor") {
                      cubitApp.listOfDrCases.clear();
                      cubitApp.isFilter
                          ? cubitApp.getFilteredDrCases()
                          : cubitApp.getDrCases();
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 18,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        cubitApp.otherImg!,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      cubitApp.otherName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 13,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var msg = cubitApp.listOfMessages[index];
                          if (userType == "SpecialNeed") {
                            if (cubitApp.spModel.uId == msg.senderId) {
                              return myMsgs(context, msg);
                            }
                            return msgs(context, msg);
                          } else {
                            if (cubitApp.spModel.uId == msg.senderId) {
                              return msgs(context, msg);
                            }
                            return myMsgs(context, msg);
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 7),
                        itemCount: cubitApp.listOfMessages.length,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 13,
                        top: 3,
                        bottom: 3,
                        right: 3,
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: bg,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: cubitApp.ctrlMsg,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type Here...",
                              ),
                            ),
                          ),
                          Visibility(
                            visible: cubitApp.ctrlMsg.text.isNotEmpty,
                            child: SizedBox(
                              width: 54,
                              child: btn(
                                fun: () {
                                  cubitApp.sendMessage(
                                    context: context,
                                    receivedId: cubitApp.otherUId!,
                                    time: DateTime.now().toString(),
                                    message: cubitApp.ctrlMsg.text,
                                  );
                                  cubitApp.ctrlMsg.clear();
                                },
                                isTxt: false,
                                input: Icon(
                                  Icons.send_outlined,
                                  color: bg,
                                ),
                                clr: Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget myMsgs(
    context,
    Messages model,
  ) =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: InkWell(
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(13.7),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 13,
                          width: double.infinity,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: txt(
                                      context: context,
                                      txt: "Warning",
                                      bd: true),
                                  content: txt(
                                    context: context,
                                    txt: "You will delete message only for you",
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        AppCubit.get(context).deleteMyMessage(
                                          msgId: model.messageId!,
                                          receiverId:
                                              AppCubit.get(context).otherUId!,
                                        );
                                        for (var i = 0; i < 2; i++) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Delete"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // AppCubit.get(context).getMessages(
                                        //   receiverId: uModel.uId!,
                                        // );
                                        for (var i = 0; i < 2; i++) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            child: txt(
                              context: context,
                              txt: "Delete for me",
                              sz: 23,
                              bd: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                          width: double.infinity,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: txt(
                                      context: context,
                                      txt: "Warning",
                                      bd: true),
                                  content: txt(
                                    context: context,
                                    txt:
                                        "You will delete message for every one",
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        AppCubit.get(context).deleteMessage(
                                          msgId: model.messageId!,
                                          receiverId:
                                              AppCubit.get(context).otherUId!,
                                        );
                                        for (var i = 0; i < 2; i++) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Delete"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // AppCubit.get(context).getMessages(
                                        //   receiverId: uModel.uId!,
                                        // );
                                        for (var i = 0; i < 2; i++) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            child: txt(
                              context: context,
                              txt: "Delete for every one",
                              sz: 23,
                              bd: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 1.7),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  bg.withOpacity(0.9),
                  bg.withOpacity(0.8),
                  bg.withOpacity(0.7),
                  bg.withOpacity(0.6),
                  bg,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
                bottomLeft: Radius.circular(13),
              ),
            ),
            child: txt(
              context: context,
              txt: model.message!,
              bd: true,
              isClr: true,
              clr: wt,
            ),
          ),
        ),
      );

  Widget msgs(
    context,
    Messages model,
  ) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: InkWell(
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(13.7),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 13,
                          width: double.infinity,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: txt(
                                      context: context,
                                      txt: "Warning",
                                      bd: true),
                                  content: txt(
                                    context: context,
                                    txt: "You will delete message only for you",
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        AppCubit.get(context).deleteMyMessage(
                                          msgId: model.messageId!,
                                          receiverId:
                                              AppCubit.get(context).otherUId!,
                                        );
                                        for (var i = 0; i < 2; i++) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Delete"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // AppCubit.get(context).getMessages(
                                        //   receiverId: uModel.uId!,
                                        // );
                                        for (var i = 0; i < 2; i++) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            child: txt(
                              context: context,
                              txt: "Delete for me",
                              sz: 23,
                              bd: true,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                          width: double.infinity,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //           title: txt(
                        //               context: context,
                        //               txt: "Warning",
                        //               bd: true),
                        //           content: txt(
                        //             context: context,
                        //             txt:
                        //                 "You will delete message for every one",
                        //           ),
                        //           actions: <Widget>[
                        //             ElevatedButton(
                        //               onPressed: () {
                        //                 AppCubit.get(context).deleteMessage(
                        //                   msgId: model.messageId!,
                        //                   receiverId: AppCubit.get(context)
                        //                       .userModel
                        //                       .uId!,
                        //                 );
                        //                 Navigator.of(context).pop();
                        //               },
                        //               child: const Text("Delete"),
                        //             ),
                        //             ElevatedButton(
                        //               onPressed: () {
                        //                 AppCubit.get(context).getMessages(
                        //                   receiverId: AppCubit.get(context)
                        //                       .userModel
                        //                       .uId!,
                        //                 );
                        //                 Navigator.of(context).pop();
                        //               },
                        //               child: const Text("Cancel"),
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     );
                        //   },
                        //   child: SizedBox(
                        //     child: txt(
                        //       context: context,
                        //       txt: "Delete for every one",
                        //       sz: 23,
                        //       bd: true,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 1.7),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    gy.withOpacity(0.9),
                    gy.withOpacity(0.8),
                    gy.withOpacity(0.7),
                    gy.withOpacity(0.6),
                    gy,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
              ),
              child: txt(
                context: context,
                txt: model.message!,
                bd: true,
              ),
            ),
          ),
        ),
      );

  // Widget myMsgs(
  //   context,
  //   Messages model,
  // ) =>
  //     Align(
  //       alignment: AlignmentDirectional.centerEnd,
  //       child: InkWell(
  //         onLongPress: () {
  //           showModalBottomSheet(
  //             context: context,
  //             builder: (BuildContext bc) {
  //               return SafeArea(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(13.7),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const SizedBox(
  //                         height: 13,
  //                         width: double.infinity,
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           showDialog(
  //                             context: context,
  //                             builder: (BuildContext context) {
  //                               return AlertDialog(
  //                                 title: txt(
  //                                     context: context,
  //                                     txt: "Warning",
  //                                     bd: true),
  //                                 content: txt(
  //                                   context: context,
  //                                   txt: "You will delete message only for you",
  //                                 ),
  //                                 actions: <Widget>[
  //                                   ElevatedButton(
  //                                     onPressed: () {
  //                                       AppCubit.get(context).deleteMyMessage(
  //                                         msgId: model.messageId!,
  //                                         receiverId:
  //                                             AppCubit.get(context).otherUId!,
  //                                       );
  //                                       for (var i = 0; i < 2; i++) {
  //                                         Navigator.of(context).pop();
  //                                       }
  //                                     },
  //                                     child: const Text("Delete"),
  //                                   ),
  //                                   ElevatedButton(
  //                                     onPressed: () {
  //                                       AppCubit.get(context).getMessages(
  //                                         receiverId:
  //                                             AppCubit.get(context).otherUId!,
  //                                       );
  //                                       Navigator.of(context).pop();
  //                                     },
  //                                     child: const Text("Cancel"),
  //                                   ),
  //                                 ],
  //                               );
  //                             },
  //                           );
  //                         },
  //                         child: SizedBox(
  //                           child: txt(
  //                             context: context,
  //                             txt: "Delete for me",
  //                             sz: 23,
  //                             bd: true,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         height: 18,
  //                         width: double.infinity,
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           showDialog(
  //                             context: context,
  //                             builder: (BuildContext context) {
  //                               return AlertDialog(
  //                                 title: txt(
  //                                     context: context,
  //                                     txt: "Warning",
  //                                     bd: true),
  //                                 content: txt(
  //                                   context: context,
  //                                   txt:
  //                                       "You will delete message for every one",
  //                                 ),
  //                                 actions: <Widget>[
  //                                   ElevatedButton(
  //                                     onPressed: () {
  //                                       AppCubit.get(context).deleteMessage(
  //                                         msgId: model.messageId!,
  //                                         receiverId:
  //                                             AppCubit.get(context).otherUId!,
  //                                       );
  //                                       for (var i = 0; i < 2; i++) {
  //                                         Navigator.of(context).pop();
  //                                       }
  //                                     },
  //                                     child: const Text("Delete"),
  //                                   ),
  //                                   ElevatedButton(
  //                                     onPressed: () {
  //                                       AppCubit.get(context).getMessages(
  //                                         receiverId:
  //                                             AppCubit.get(context).otherUId!,
  //                                       );
  //                                       Navigator.of(context).pop();
  //                                     },
  //                                     child: const Text("Cancel"),
  //                                   ),
  //                                 ],
  //                               );
  //                             },
  //                           );
  //                         },
  //                         child: SizedBox(
  //                           child: txt(
  //                             context: context,
  //                             txt: "Delete for every one",
  //                             sz: 23,
  //                             bd: true,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         height: 13,
  //                         width: double.infinity,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //         child: Container(
  //           constraints: BoxConstraints(
  //               maxWidth: MediaQuery.sizeOf(context).width / 1.7),
  //           padding: const EdgeInsets.all(7),
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [
  //                 bg.withOpacity(0.9),
  //                 bg.withOpacity(0.8),
  //                 bg.withOpacity(0.7),
  //                 bg.withOpacity(0.6),
  //                 bg,
  //               ],
  //             ),
  //             borderRadius: const BorderRadius.only(
  //               topLeft: Radius.circular(13),
  //               topRight: Radius.circular(13),
  //               bottomLeft: Radius.circular(13),
  //             ),
  //           ),
  //           child: txt(
  //             context: context,
  //             txt: model.message!,
  //             bd: true,
  //           ),
  //         ),
  //       ),
  //     );
  // Widget msgs(
  //   context,
  //   Messages model,
  // ) =>
  //     Align(
  //       alignment: AlignmentDirectional.centerStart,
  //       child: InkWell(
  //         onLongPress: () {
  //           showModalBottomSheet(
  //             context: context,
  //             builder: (BuildContext bc) {
  //               return SafeArea(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(13.7),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const SizedBox(
  //                         height: 13,
  //                         width: double.infinity,
  //                       ),
  //                       InkWell(
  //                         onTap: () {
  //                           showDialog(
  //                             context: context,
  //                             builder: (BuildContext context) {
  //                               return AlertDialog(
  //                                 title: txt(
  //                                     context: context,
  //                                     txt: "Warning",
  //                                     bd: true),
  //                                 content: txt(
  //                                   context: context,
  //                                   txt: "You will delete message only for you",
  //                                 ),
  //                                 actions: <Widget>[
  //                                   ElevatedButton(
  //                                     onPressed: () {
  //                                       AppCubit.get(context).deleteMyMessage(
  //                                         msgId: model.messageId!,
  //                                         receiverId:
  //                                             AppCubit.get(context).otherUId!,
  //                                       );
  //                                       for (var i = 0; i < 2; i++) {
  //                                         Navigator.of(context).pop();
  //                                       }
  //                                     },
  //                                     child: const Text("Delete"),
  //                                   ),
  //                                   ElevatedButton(
  //                                     onPressed: () {
  //                                       AppCubit.get(context).getMessages(
  //                                         receiverId:
  //                                             AppCubit.get(context).otherUId!,
  //                                       );
  //                                       Navigator.of(context).pop();
  //                                     },
  //                                     child: const Text("Cancel"),
  //                                   ),
  //                                 ],
  //                               );
  //                             },
  //                           );
  //                         },
  //                         child: SizedBox(
  //                           child: txt(
  //                             context: context,
  //                             txt: "Delete for me",
  //                             sz: 23,
  //                             bd: true,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         height: 13,
  //                         width: double.infinity,
  //                       ),
  //                       // InkWell(
  //                       //   onTap: () {
  //                       //     showDialog(
  //                       //       context: context,
  //                       //       builder: (BuildContext context) {
  //                       //         return AlertDialog(
  //                       //           title: txt(
  //                       //               context: context,
  //                       //               txt: "Warning",
  //                       //               bd: true),
  //                       //           content: txt(
  //                       //             context: context,
  //                       //             txt:
  //                       //                 "You will delete message for every one",
  //                       //           ),
  //                       //           actions: <Widget>[
  //                       //             ElevatedButton(
  //                       //               onPressed: () {
  //                       //                 AppCubit.get(context).deleteMessage(
  //                       //                   msgId: model.messageId!,
  //                       //                   receiverId: AppCubit.get(context)
  //                       //                       .userModel
  //                       //                       .uId!,
  //                       //                 );
  //                       //                 Navigator.of(context).pop();
  //                       //               },
  //                       //               child: const Text("Delete"),
  //                       //             ),
  //                       //             ElevatedButton(
  //                       //               onPressed: () {
  //                       //                 AppCubit.get(context).getMessages(
  //                       //                   receiverId: AppCubit.get(context)
  //                       //                       .userModel
  //                       //                       .uId!,
  //                       //                 );
  //                       //                 Navigator.of(context).pop();
  //                       //               },
  //                       //               child: const Text("Cancel"),
  //                       //             ),
  //                       //           ],
  //                       //         );
  //                       //       },
  //                       //     );
  //                       //   },
  //                       //   child: SizedBox(
  //                       //     child: txt(
  //                       //       context: context,
  //                       //       txt: "Delete for every one",
  //                       //       sz: 23,
  //                       //       bd: true,
  //                       //     ),
  //                       //   ),
  //                       // ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //         child: Container(
  //           constraints: BoxConstraints(
  //               maxWidth: MediaQuery.sizeOf(context).width / 1.7),
  //           child: Container(
  //             padding: const EdgeInsets.all(7),
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: [
  //                   gy.withOpacity(0.9),
  //                   gy.withOpacity(0.8),
  //                   gy.withOpacity(0.7),
  //                   gy.withOpacity(0.6),
  //                   gy,
  //                 ],
  //               ),
  //               borderRadius: const BorderRadius.only(
  //                 topLeft: Radius.circular(13),
  //                 topRight: Radius.circular(13),
  //                 bottomRight: Radius.circular(13),
  //               ),
  //             ),
  //             child: txt(
  //               context: context,
  //               txt: model.message!,
  //               bd: true,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
}
