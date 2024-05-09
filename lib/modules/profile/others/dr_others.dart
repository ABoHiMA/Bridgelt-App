import 'package:bridgelt/modules/messages/screen/other_messages_screen.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OthersDoctorProfile extends StatelessWidget {
  const OthersDoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        var drModel = cubitApp.drModel;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 18,
              ),
            ),
            centerTitle: true,
            title: const Image(
              image: AssetImage("assets/imgs/logo.png"),
              height: 49,
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       pgn(context, const MessagesMenu());
            //     },
            //     icon: const Icon(Icons.messenger_outline_sharp),
            //   ),
            // ],
          ),
          body: Column(
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            backgroundImage:
                                NetworkImage(drModel.profileImage!),
                          ),
                        ),
                        Column(
                          children: [
                            txt(
                              context: context,
                              txt: drModel.name!,
                              clr: wt,
                              isClr: true,
                              sz: 26,
                            ),
                            const SizedBox(height: 10),
                            txt(
                              context: context,
                              txt: '${drModel.userType} - ${drModel.specially}',
                              clr: wt,
                              isClr: true,
                              sz: 18,
                              bd: true,
                            ),
                            const SizedBox(height: 10),
                            txt(
                              context: context,
                              txt: 'Hospital: ${drModel.hospitalName}',
                              clr: wt,
                              isClr: true,
                              sz: 16,
                            ),
                            const SizedBox(height: 10),
                            txt(
                              context: context,
                              txt: 'Phone: ${drModel.phone}',
                              clr: wt,
                              isClr: true,
                              sz: 16,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: 35,
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      AppCubit.get(context).getMessages(
                                          receiverId:
                                              AppCubit.get(context).otherUId!,context: context);
                                      pgn(
                                        context,
                                        const OtherMessagesScreen(),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Message',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            color: bg,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chat_bubble_outline,
                                          color:
                                              Color.fromARGB(255, 76, 23, 161),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                width: 110,
                                child: ElevatedButton(
                                  onPressed: () {
                                    urlcall(phone: drModel.phone!);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Call',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          color: bg,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.call_end_outlined,
                                        color: Color.fromARGB(255, 76, 23, 161),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
          ),
        );
      },
    );
  }
}
