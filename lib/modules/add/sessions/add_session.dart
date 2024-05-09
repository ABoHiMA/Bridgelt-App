import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddSession extends StatelessWidget {
  const AddSession({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrlLink = TextEditingController();
    DateTime now = DateTime.now();
    var time = DateFormat('dd/MM/yyyy hh:mm').format(now);
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreateSessionSuccState) {
          msg(
            msg: "Session Published",
            bg: ToastStates.SUCC,
          );
          pgx(context, const Bridgelt());
          index = 2;
        }
      },
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        var model = cubitApp.drModel;
        cubitApp.ctrlSession.addListener(() {
          cubitApp.caseFieldListener();
        });

        String link =
            ctrlLink.text.isNotEmpty ? ctrlLink.text : "No Link Found";

        return Scaffold(
          appBar: AppBar(
            title: const Text("Create Session"),
            leading: IconButton(
              onPressed: () {
                pgx(context, const Bridgelt());
                index = 0;
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            titleSpacing: 0.0,
            actions: [
              state is AppCreateSessionLoadingState
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.6),
                      child: SizedBox(
                        height: 29,
                        width: 29,
                        child: CircularProgressIndicator(color: bg),
                      ),
                    )
                  : Visibility(
                      visible: cubitApp.ctrlSession.text.isNotEmpty &&
                          cubitApp.ctrlSession.text.startsWith(' ') != true,
                      child: TextButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubitApp.createSession(
                              text: cubitApp.ctrlSession.text,
                              time: time.toString(),
                              link: link,
                            );
                          }
                        },
                        child: txt(
                          context: context,
                          txt: "Publish",
                          isClr: true,
                          bd: true,
                          clr: bg,
                        ),
                      ),
                    ),
            ],
          ),
          body: Form(
            key: formkey,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 7.13, left: 7.13, bottom: 7.13),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(model.profileImage!),
                        radius: 29,
                      ),
                      const SizedBox(width: 9),
                      txt(
                        txt: "Dr. ${model.name}",
                        context: context,
                        bd: true,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(7.13),
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            msg(
                              msg: "No case found...!",
                              bg: ToastStates.ERR,
                            );
                          }
                          return null;
                        },
                        controller: cubitApp.ctrlSession,
                        decoration: const InputDecoration(
                          hintText: "Type Here...",
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: txt(
                      context: context,
                      txt: "Link of meetings",
                      bd: true,
                      isClr: true,
                      clr: bg,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        child: cubitApp.link
                            ? TextButton(
                                onPressed: () {
                                  if (link != "No Link Found") {
                                    url(link: link);
                                  }
                                },
                                child: txt(
                                  context: context,
                                  txt: link,
                                  bd: true,
                                  isClr: true,
                                  clr: bg,
                                ),
                              )
                            : TextFormField(
                                controller: ctrlLink,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Put Here...",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    link.isEmpty;
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  cubitApp.chgLink();
                                  link = ctrlLink.text;
                                },
                              ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        child: cubitApp.link
                            ? IconButton(
                                onPressed: () {
                                  cubitApp.chgLink();
                                  link == "No Link Found"
                                      ? ctrlLink.clear()
                                      : ctrlLink.text = link;
                                },
                                icon: const Icon(Icons.edit_outlined),
                              )
                            : IconButton(
                                onPressed: () {
                                  cubitApp.chgLink();
                                  link = ctrlLink.text;
                                },
                                icon: const Icon(Icons.done_outline),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
