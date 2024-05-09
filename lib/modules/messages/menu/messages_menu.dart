import 'package:bridgelt/models/user_model.dart';
import 'package:bridgelt/modules/messages/screen/messages.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesMenu extends StatelessWidget {
  const MessagesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: backBtn(context),
            centerTitle: true,
            title: txt(context: context, txt: "Chats", sz: 23),
          ),
          body: ConditionalBuilder(
            condition: state is! AppLoadingChatsState,
            builder: (context) => cubitApp.listOfUsers.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        messages(context, cubitApp.listOfUsers[index]),
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: cubitApp.listOfUsers.length,
                  )
                : Center(
                    child: txt(
                      context: context,
                      txt: "No Chats Yet",
                      bd: true,
                      isClr: true,
                      sz: 29,
                    ),
                  ),
            fallback: (context) =>
                Center(child: CircularProgressIndicator(color: bg)),
          ),
        );
      },
    );
  }
}

Widget messages(context, UserData model) => Padding(
      padding: const EdgeInsets.all(7.13),
      child: Card(
        surfaceTintColor: bg,
        shadowColor: bg,
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            pgn(
              context,
              MessagesScreen(uModel: model),
            );
          },
          child: Dismissible(
            key: Key(model.uId!),
            background: Container(
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.delete_forever_outlined, color: wt),
                    Icon(Icons.delete_forever_outlined, color: wt),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) {

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: txt(context: context, txt: "Warning", bd: true),
                    content:
                        txt(context: context, txt: "You will delete this chat"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          AppCubit.get(context).deleteChat(id: model.uId!).then(
                              (value) => msg(
                                  msg: "Chat deleted successfully",
                                  bg: ToastStates.SUCC));
                          Navigator.of(context).pop();
                        },
                        child: const Text("Delete"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AppCubit.get(context).getChats();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  );
                },
              );
           
            },
            child: Container(
              margin: const EdgeInsets.all(7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          model.profileImage!,
                        ),
                        radius: 23,
                      ),
                      const SizedBox(width: 9),
                      Column(
                        children: [
                          txt(
                            txt: model.name!,
                            context: context,
                            bd: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
