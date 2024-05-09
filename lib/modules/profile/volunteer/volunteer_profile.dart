// ignore_for_file: non_constant_identifier_names
import 'package:bridgelt/modules/profile/volunteer/v_edit.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolunteerProfile extends StatelessWidget {
  const VolunteerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        var vModel = cubitApp.vModel;
        return Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 103, 85, 183),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(vModel.profileImage!),
                        ),
                      ),
                      Column(
                        children: [
                          txt(
                            context: context,
                            txt: vModel.name!,
                            clr: wt,
                            isClr: true,
                            sz: 26,
                            st: false,
                          ),
                          const SizedBox(height: 10),
                          txt(
                            context: context,
                            txt: userType!,
                            clr: wt,
                            isClr: true,
                            sz: 20,
                            bd: true,
                            st: false,
                          ),
                          const SizedBox(height: 10),
                          txt(
                            context: context,
                            txt: 'Phone: ${vModel.phone}',
                            clr: wt,
                            isClr: true,
                            sz: 16,
                            st: false,
                          ),
                          const SizedBox(height: 10),
                          txt(
                            context: context,
                            txt:
                                "From: ${vModel.volunteerGovernorate}, ${vModel.volunteerCity}",
                            clr: wt,
                            isClr: true,
                            sz: 16,
                            st: false,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 35,
                          width: 180,
                          child: ElevatedButton(
                            onPressed: () {
                              pgn(context, const EditVolunteerProfile());
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                txt(
                                  context: context,
                                  txt: "Edit Profile",
                                  isClr: true,
                                  clr: bg,
                                  sz: 17,
                                  bd: true,
                                ),
                                const SizedBox(width: 3),
                                Icon(
                                  Icons.edit_outlined,
                                  color: bg,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ],
        );
      },
    );
  }
}
