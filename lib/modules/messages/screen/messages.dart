import 'package:bridgelt/models/messages_model.dart';
import 'package:bridgelt/models/user_model.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({
    super.key,
    required this.uModel,
  });
  final UserData uModel;

  @override
  Widget build(BuildContext context) {
    // bool isBtn = false;
    // var ctrlMsg = TextEditingController();

    return Builder(builder: (context) {
      AppCubit.get(context)
          .getMessages(receiverId: uModel.uId!, context: context);

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
              leading: backBtn(context),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      uModel.profileImage!,
                    ),
                  ),
                  const SizedBox(width: 9),
                  txt(
                    txt: uModel.name!,
                    context: context,
                    bd: true,
                    sz: 18,
                  ),
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
                        if (uModel.uId == msg.senderId) {
                          return msgs(context, msg);
                        }
                        return myMsgs(context, msg);
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
                          visible: cubitApp.ctrlMsg.text.isNotEmpty &&
                              cubitApp.ctrlMsg.text.startsWith(' ') != true,
                          child: SizedBox(
                            width: 54,
                            child: btn(
                              fun: () {
                                cubitApp
                                    .sendMessage(
                                  context: context,
                                  receivedId: uModel.uId!,
                                  time: DateTime.now().toString(),
                                  message: cubitApp.ctrlMsg.text,
                                )
                                    .then(
                                  (value) {
                                    AppCubit.get(context).getMessages(
                                      receiverId: uModel.uId!,
                                      context: context,
                                    );
                                  },
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
    });
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
                                          receiverId: uModel.uId!,
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
                                          receiverId: uModel.uId!,
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
                                          receiverId: uModel.uId!,
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
}
