import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddCase extends StatelessWidget {
  const AddCase({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var time = DateFormat('dd/MM/yyyy hh:mm').format(now);
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreateCaseSuccState) {
          AppCubit.get(context).ctrlCase.clear();
          msg(
            msg: "Case Published",
            bg: ToastStates.SUCC,
          );
          pgx(context, const Bridgelt());
          index = 2;
        }
      },
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        var model = cubitApp.spModel;
        cubitApp.ctrlCase.addListener(() {
          cubitApp.caseFieldListener();
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Create Case",
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            titleSpacing: 0.0,
            actions: [
              state is AppCreateCaseLoadingState
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.6),
                      child: SizedBox(
                        height: 29,
                        width: 29,
                        child: CircularProgressIndicator(color: bg),
                      ),
                    )
                  : Visibility(
                      visible: cubitApp.ctrlCase.text.isNotEmpty &&
                          cubitApp.ctrlCase.text.startsWith(" ") != true,
                      child: TextButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubitApp.createCase(
                              text: cubitApp.ctrlCase.text,
                              time: time.toString(),
                              gov: AppCubit.get(context).selectedCurrentGov,
                              city: AppCubit.get(context).selectedCurrentCity,
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
              padding: const EdgeInsets.only(top: 7.13, left: 7.13),
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
                        txt: model.name!,
                        context: context,
                        bd: true,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(7.13),
                      child: TextFormField(
                        controller: cubitApp.ctrlCase,
                        decoration: const InputDecoration(
                          hintText: "What's your Case ....",
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          txt(
                            context: context,
                            sz: 16,
                            txt: "Governorate",
                          ),
                          DropdownButton<String>(
                            value: AppCubit.get(context).selectedCurrentGov,
                            onChanged: (String? newValue) {
                              AppCubit.get(context).choiseCurrentGov(newValue);
                            },
                            items: governorate.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          txt(
                            context: context,
                            sz: 16,
                            txt: "City",
                          ),
                          DropdownButton<String>(
                            value: AppCubit.get(context).selectedCurrentCity,
                            onChanged: (String? newValue) {
                              AppCubit.get(context).selectedCurrentCity =
                                  newValue!;
                              AppCubit.get(context).dropdown(newValue);
                            },
                            items: governorate[
                                    AppCubit.get(context).selectedCurrentGov]!
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
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
