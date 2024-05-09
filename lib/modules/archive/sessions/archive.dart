import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/models/session_model.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedSeesions extends StatelessWidget {
  const ArchivedSeesions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                pgx(context, const Bridgelt());
                index = 0;
              },
              icon: back,
            ),
            centerTitle: true,
            title: txt(context: context, txt: "Archive", sz: 23),
          ),
          body: ConditionalBuilder(
            condition: state is! AppLoadingGetSessionsState,
            builder: (context) => cubitApp.listOfArchivedSessions.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => drSession(
                        context, index, cubitApp.listOfArchivedSessions[index]),
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: cubitApp.listOfArchivedSessions.length,
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
        );
      },
    );
  }
}

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
                                    AppCubit.get(context).deleteArchiveSession(
                                        id: model.sessionId!);
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
                                  txt: "You will Publish this Session"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .unArchiveSession(id: model.sessionId!);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Publish"),
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
                      text: "Publish",
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
