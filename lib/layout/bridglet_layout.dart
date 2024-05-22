import 'package:bridgelt/modules/add/cases/add_case.dart';
import 'package:bridgelt/modules/about/about.dart';
import 'package:bridgelt/modules/add/sessions/add_session.dart';
import 'package:bridgelt/modules/archive/cases/archive.dart';
import 'package:bridgelt/modules/archive/sessions/archive.dart';
import 'package:bridgelt/modules/home/home.dart';
import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/modules/messages/menu/messages_menu.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/bridgelt/cubit.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:bridgelt/shared/network/local/cache_h.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bridgelt extends StatelessWidget {
  const Bridgelt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppLogoutSuccState) {
          msg(
            msg: "Logged out",
            bg: ToastStates.SUCC,
          );
          CacheHelper.clearData(
            key: 'uId',
          ).then((value) {
            CacheHelper.clearData(key: "fingerprint").then((value) {
              fPrint = "";
              pgx(context, const Login());
              uId = null;
              userType = null;
              verify = null;
              index = 0;
              CacheHelper.clearData(key: 'userType');
              CacheHelper.clearData(key: 'verify');
            });
          });
        }
      },
      builder: (BuildContext context, state) {
        var cubitApp = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Image(
                image: AssetImage("assets/imgs/logo.png"),
                height: 49,
              ),
            actions: [
              GestureDetector(
                onTap: () {
                  pgn(context, const MessagesMenu());
                  cubitApp.getChats();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 13,
                  ),
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: bg.withOpacity(0.9),
                        width: 3,
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 13,
                    ),
                    child: txt(
                      context: context,
                      txt: cubitApp.listOfUsers.length.toString(),
                      sz: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      const DrawerHeader(
                        child: Image(
                          image: AssetImage("assets/imgs/logo.png"),
                          height: 49,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            pgx(context, const Bridgelt());
                            index = 0;
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.home),
                              const SizedBox(width: 9),
                              txt(
                                context: context,
                                txt: "Home",
                                isClr: true,
                                clr: bg,
                                spc: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      userType == "Doctor"
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  pgn(context, const ArchivedSeesions());
                                  cubitApp.getArchiveSession();
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.archive_outlined),
                                    const SizedBox(width: 9),
                                    txt(
                                      context: context,
                                      txt: "Archive",
                                      isClr: true,
                                      clr: bg,
                                      spc: 3,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : userType == "SpecialNeed"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      pgn(context, const ArchivedCases());
                                      cubitApp.getArchiveCase();
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.archive_outlined),
                                        const SizedBox(width: 9),
                                        txt(
                                          context: context,
                                          txt: "Archive",
                                          isClr: true,
                                          clr: bg,
                                          spc: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            pgx(context, const About());
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline),
                              const SizedBox(width: 9),
                              txt(
                                context: context,
                                txt: "About",
                                isClr: true,
                                clr: bg,
                                spc: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            cubitApp.userLogout();
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.exit_to_app_outlined),
                              const SizedBox(width: 9),
                              txt(
                                context: context,
                                txt: "Logout",
                                isClr: true,
                                clr: bg,
                                spc: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 9,
                          horizontal: 13,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.fingerprint_outlined,
                                  color: bg,
                                  size: 29,
                                ),
                                const SizedBox(width: 9),
                                txt(
                                  context: context,
                                  txt: "Login with\nFinger print",
                                  isClr: true,
                                  clr: bg,
                                  spc: 3,
                                  sz: 16,
                                ),
                              ],
                            ),
                            Switch(
                              value: cubitApp.isSwitchChecked,
                              onChanged: (value) {
                                AppCubit.get(context).enableFingerPrint(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        "Select Theme: ",
                        style: TextStyle(
                          color: bg,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      DropdownButton<String>(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        value: BridgeltCubit.get(context).selectedThm,
                        onChanged: (String? newValue) {
                          BridgeltCubit.get(context).selectedThm = newValue!;
                          BridgeltCubit.get(context).chgMode(newValue);
                        },
                        items: <String>[
                          'System Default',
                          'Light Mode',
                          'Dark Mode',
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: verify == true
              ? ConditionalBuilder(
                  condition: userType == "Volunteer",
                  builder: (context) => index == 0
                      ? FloatingActionButton(
                          onPressed: () {
                            showFilterDialog(context);
                          },
                          child: const Icon(Icons.vertical_distribute_outlined),
                        )
                      : const SizedBox(),
                  fallback: (context) => ConditionalBuilder(
                    condition: userType == "Doctor",
                    builder: (context) => index == 0
                        ? FloatingActionButton(
                            heroTag: 'filter',
                            onPressed: () {
                              showFilterDialog(context);
                            },
                            child:
                                const Icon(Icons.vertical_distribute_outlined),
                          )
                        : const SizedBox(),
                    fallback: (context) => Container(
                      alignment: const Alignment(0.1, 0.97),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: FloatingActionButton(
                        onPressed: () {
                          pgn(context, const AddCase());
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                )
              : null,
          body: ConditionalBuilder(
            condition: verify == true,
            builder: (context) => Stack(
              children: [
                drSelected || userType == "Doctor"
                    ? cubitApp.drScreens[index]
                    : spSelected || userType == "SpecialNeed"
                        ? cubitApp.spScreens[index]
                        : vSelected || userType == "Volunteer"
                            ? cubitApp.vScreens[index]
                            : Container(),
                Container(
                  alignment: const Alignment(0.0, 1.0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 10,
                  ),
                  child: FloatingNavbar(
                    width: vSelected || userType == "Volunteer"
                        ? MediaQuery.sizeOf(context).width / 2.5
                        : MediaQuery.sizeOf(context).width / 1.7,
                    onTap: (int val) {
                      cubitApp.chgBtmNav(val);
                    },
                    currentIndex: index,
                    items: vSelected || userType == "Volunteer"
                        ? cubitApp.itemsV
                        : cubitApp.items,
                    borderRadius: 69,
                    margin: const EdgeInsets.only(bottom: 0),
                    backgroundColor: bk.withOpacity(0.69),
                    selectedBackgroundColor: null,
                    selectedItemColor: bg,
                  ),
                ),
                Container(
                  alignment: const Alignment(0.0, 0.90),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: userType == "Doctor"
                      ? FloatingActionButton(
                          heroTag: 'session',
                          onPressed: () {
                            pgn(context, const AddSession());
                          },
                          child: const Icon(Icons.add),
                        )
                      : null,
                )
              ],
            ),
            fallback: (context) => const Home(),
          ),
        );
      },
    );
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Governorate to Filter'),
          content: DropdownButtonFormField<String>(
            value: AppCubit.get(context).selectedFilteredGovernorate,
            hint: const Text('Select Governorate'),
            items: governorates
                .map<DropdownMenuItem<String>>((String governorate) {
              return DropdownMenuItem<String>(
                value: governorate,
                child: Text(governorate),
              );
            }).toList(),
            onChanged: (String? value) {
              AppCubit.get(context).selectedFilteredGovernorate = value;
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                AppCubit.get(context).isFilter = true;
                userType == "Doctor"
                    ? AppCubit.get(context).getFilteredDrCases()
                    : AppCubit.get(context).getFilteredVCases();
                Navigator.of(context).pop();
              },
              child: const Text('Filter'),
            ),
            ElevatedButton(
              onPressed: () {
                AppCubit.get(context).isFilter = false;
                userType == "Doctor"
                    ? AppCubit.get(context).getDrCases()
                    : AppCubit.get(context).getVCases();
                AppCubit.get(context).selectedFilteredGovernorate = null;
                Navigator.of(context).pop();
              },
              child: const Text('Clear Filter'),
            ),
          ],
        );
      },
    );
  }
}
