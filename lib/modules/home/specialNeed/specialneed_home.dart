import 'package:bridgelt/models/session_model.dart';
import 'package:bridgelt/modules/profile/others/dr_others.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialNeedHomePage extends StatelessWidget {
  const SpecialNeedHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppGetOthersUserDataSuccState) {
          pgn(context, const OthersDoctorProfile());
        }
      },
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        return ConditionalBuilder(
          condition: state is! AppLoadingGetSessionsState,
          builder: (context) => cubitApp.listOfSessions.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      session(context, index, cubitApp.listOfSessions[index]),
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: cubitApp.listOfSessions.length,
                )
              : Center(
                  child: txt(
                    context: context,
                    txt: "No Sessions Yet",
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

Widget session(
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
                          SizedBox(
                            height: 30,
                            child: TextButton(
                              style: const ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.zero),
                              ),
                              onPressed: () {
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
                            txt: "Doctor - ${model.specially}",
                            sz: 13,
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
              model.link != "No Link Found"
                  ? Column(
                      children: [
                        const Divider(),
                        const SizedBox(height: 7),
                        btn(
                          fun: () {
                            if (model.link != "No Link Found") {
                              url(link: model.link!);
                            }
                          },
                          isTxt: true,
                          text: model.link != "No Link Found"
                              ? "Link of session"
                              : "No Link Found",
                          clr: bg,
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
