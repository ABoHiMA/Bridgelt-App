// ignore_for_file: avoid_print
import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/modules/login/cubit/login_cubit.dart';
import 'package:bridgelt/modules/login/cubit/login_states.dart';
import 'package:bridgelt/modules/login/screen/password_reset.dart';
import 'package:bridgelt/modules/register/screen/register.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/network/local/cache_h.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    var ctrlMail = TextEditingController();
    var ctrlPass = TextEditingController();
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrState) {
          msg(
            msg: state.error,
            bg: ToastStates.ERR,
          );
        }
        if (state is LoginSuccState) {
          CacheHelper.saveData(
            key: 'uId',
            val: state.uId,
          ).then((value) {
            AppCubit.get(context).enableFingerPrint(true);
            print('ID SAVVED');
          }).catchError((error) {
            print("ERR CACHE${error.toString()}");
          });
          AppCubit.get(context).getUserData();
          // spSelected || userType == "SpecialNeed"
          //     ? AppCubit.get(context).getSpCases()
          //     : AppCubit.get(context).getCases();
          msg(
            msg: "Welcome Back",
            bg: ToastStates.SUCC,
          );
          pgx(context, const Bridgelt());
        }
      },
      builder: (context, state) {
        var cubitLogin = LoginCubit.get(context);
        return Scaffold(
          body: Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 69),
                      Container(
                        height: MediaQuery.sizeOf(context).height / 3,
                        padding: const EdgeInsets.all(18.6),
                        child: const Image(
                          image: AssetImage('assets/imgs/bridgeltph.png'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Column(
                        children: [
                          tff(
                            txt: "E-Mail",
                            icon: Icons.mail_outline,
                            ctrl: ctrlMail,
                            type: TextInputType.emailAddress,
                            vld: (val) {
                              if (val!.isEmpty) {
                                return 'Enter Your E-Mail';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 13),
                          tff(
                              txt: "Password",
                              icon: Icons.password_outlined,
                              ctrl: ctrlPass,
                              type: TextInputType.visiblePassword,
                              pss: cubitLogin.pass,
                              sfx: () {
                                cubitLogin.passVisible();
                              },
                              icSfx: cubitLogin.passIc,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Your Password';
                                }
                                return null;
                              },
                              smt: (val) {
                                if (formkey.currentState!.validate()) {
                                  cubitLogin.userLogin(
                                    email: ctrlMail.text,
                                    pass: ctrlPass.text,
                                  );
                                }
                              }),
                          Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () {
                                pgn(context, const PasswordReset());
                              },
                              child: const Text("Forget Password"),
                            ),
                          ),
                          const SizedBox(height: 69),
                          state is LoginLoadingState
                              ? const CircularProgressIndicator()
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: btn(
                                        fun: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            cubitLogin.userLogin(
                                              email: ctrlMail.text,
                                              pass: ctrlPass.text,
                                            );
                                          }
                                        },
                                        isTxt: true,
                                        text: 'Login',
                                        clr: bg,
                                        rd: 69,
                                        sz: 23,
                                        ht: 55,
                                        up: false,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    fPrint != ""
                                        ? Expanded(
                                            flex: 1,
                                            child: btn(
                                              fun: () {
                                                AppCubit.get(context)
                                                    .fingerPrintLogin(context);
                                              },
                                              isTxt: false,
                                              input: Icon(
                                                Icons.fingerprint_outlined,
                                                color: wt,
                                                size: 36,
                                              ),
                                              clr: bg,
                                              rd: 69,
                                              sz: 23,
                                              ht: 55,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an Account...!"),
                              TextButton(
                                style: const ButtonStyle(
                                  padding:
                                      MaterialStatePropertyAll(EdgeInsets.zero),
                                ),
                                onPressed: () {
                                  pgx(context, const Register());
                                },
                                child: const Text(" Create Account..."),
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
      },
    );
  }
}
