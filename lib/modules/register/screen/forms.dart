import 'package:bridgelt/modules/register/cubit/register_cubit.dart';
import 'package:bridgelt/modules/register/cubit/register_states.dart';
import 'package:bridgelt/modules/register/screen/forms/doctor/dr_form.dart';
import 'package:bridgelt/modules/register/screen/forms/volunteer/v_form.dart';
import 'package:bridgelt/modules/register/screen/forms/special_needs/sp_form.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forms extends StatelessWidget {
  const Forms({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitForm = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                cubitForm.resetForm();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
            centerTitle: true,
            title: txt(
              context: context,
              txt: "Bridgelt Form",
              bd: true,
              sz: 23,
              clr: bg,
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.7),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: txt(
                            context: context,
                            txt: drSelected
                                ? "I'm a Doctor"
                                : vSelected
                                    ? "I'm a Volunteer"
                                    : spSelected
                                        ? "I'm a Special Need ^_^"
                                        : "I'm a...",
                            bd: true,
                            sz: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubitForm.drBtn();
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  height: 143,
                                  width: 99,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: cubitForm.drClr,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/imgs/doctorLogo.png'),
                                        fit: BoxFit.cover,
                                        height: 99,
                                        width: 74,
                                      ),
                                      txt(
                                        context: context,
                                        txt: "Doctor",
                                        st: false,
                                        bd: true,
                                        sz: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubitForm.vBtn();
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  height: 143,
                                  width: 99,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: cubitForm.pClr,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/imgs/volunteerLogo.png'),
                                        fit: BoxFit.cover,
                                        height: 99,
                                        width: 74,
                                      ),
                                      txt(
                                        context: context,
                                        txt: "Volunteer",
                                        bd: true,
                                        st: false,
                                        sz: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubitForm.spBtn();
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  height: 143,
                                  width: 99,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: cubitForm.snClr,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/imgs/specialNeedLogo.png'),
                                        fit: BoxFit.cover,
                                        height: 99,
                                        width: 74,
                                      ),
                                      Expanded(
                                        child: txt(
                                          context: context,
                                          txt: "Special Need",
                                          bd: true,
                                          sz: 18,
                                          st: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    drSelected || vSelected || spSelected
                        ? Container(
                            height: MediaQuery.sizeOf(context).height - 330,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: clr,
                            ),
                            child: SingleChildScrollView(
                              child: Center(
                                child: drSelected
                                    ? drForm(context)
                                    : vSelected
                                        ? vForm(context)
                                        : spSelected
                                            ? spForm(context)
                                            : null,
                              ),
                            ))
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
