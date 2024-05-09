import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/models/cases_model.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedCases extends StatelessWidget {
  const ArchivedCases({super.key});

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
            condition: state is! AppLoadingGetSpCasesState,
            builder: (context) => cubitApp.listOfArchivedCases.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => spCases(
                        context, index, cubitApp.listOfArchivedCases[index]),
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: cubitApp.listOfArchivedCases.length,
                  )
                : Center(
                    child: txt(
                      context: context,
                      txt: "No Archived Cases Yet",
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
                                        .deleteArchiveCase(id: model.caseId!);
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
                                  txt: "You will Publish this case"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    AppCubit.get(context)
                                        .unArchiveCase(id: model.caseId!);
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
                      text: "Publish Case",
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
