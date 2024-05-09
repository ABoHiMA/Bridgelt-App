import 'package:bridgelt/modules/register/cubit/register_cubit.dart';
import 'package:bridgelt/modules/register/cubit/register_states.dart';
import 'package:bridgelt/modules/register/screen/forms.dart';
import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitReg = RegisterCubit.get(context);
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
                      const SizedBox(
                        height: 123,
                        child: Image(
                          image: AssetImage('assets/imgs/logo.png'),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: txt(
                          context: context,
                          txt: "Register",
                          sz: 30,
                          bd: true,
                        ),
                      ),
                      const SizedBox(height: 23),
                      tff(
                        txt: "UserName",
                        icon: Icons.person_2_outlined,
                        ctrl: cubitReg.ctrlUName,
                        type: TextInputType.name,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return 'Enter Your UserName';
                          }
                          if (val.contains(RegExp(r'[0-9]'))) {
                            return "UserName mustn't contain at least one digit";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 13),
                      tff(
                        txt: "E-Mail",
                        icon: Icons.mail_outline,
                        ctrl: cubitReg.ctrlEMail,
                        type: TextInputType.emailAddress,
                        vld: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your E-Mail';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          if (!value.contains('@')) {
                            return 'Email must contain @ symbol';
                          }
                          if (!value.contains('.')) {
                            return 'Email must contain domain (e.g., .com, .net)';
                          }
                          if (value.startsWith('.') || value.endsWith('.')) {
                            return 'Email cannot start or end with a dot';
                          }
                          if (value.split('@').length != 2) {
                            return 'Email must contain only one @ symbol';
                          }
                          if (value.contains(' ')) {
                            return 'Email cannot contain spaces';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 13),
                      tff(
                        txt: "Password",
                        icon: Icons.lock,
                        ctrl: cubitReg.ctrlPass,
                        type: TextInputType.visiblePassword,
                        vld: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain at least one uppercase letter';
                          }
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password must contain at least one lowercase letter';
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain at least one digit';
                          }

                          return null;
                        },
                        pss: cubitReg.pass,
                        sfx: () {
                          cubitReg.passVisible();
                        },
                        icSfx: cubitReg.passIc,
                      ),
                      const SizedBox(height: 13),
                      tff(
                        txt: "Repeat Password",
                        icon: Icons.lock,
                        ctrl: cubitReg.ctrlRePass,
                        type: TextInputType.visiblePassword,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return 'Enter Your Confirmation Password';
                          }
                          if (val != cubitReg.ctrlPass.text) {
                            return 'Rematch your Password, Please';
                          }
                          return null;
                        },
                        pss: cubitReg.rePass,
                        sfx: () {
                          cubitReg.rePassVisible();
                        },
                        icSfx: cubitReg.rePassIc,
                      ),
                      const SizedBox(height: 13),
                      tff(
                        txt: "Phone Number",
                        icon: Icons.phone_iphone_outlined,
                        ctrl: cubitReg.ctrlPhone,
                        type: TextInputType.phone,
                        mx: 11,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return 'Enter Your Phone Number';
                          }
                          if (val.length != 11) {
                            return 'Phone Number must be 11 numbers';
                          }
                          if (!val.startsWith('01')) {
                            return 'Phone Number must be valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 13),
                      btn(
                        fun: () {
                          if (formkey.currentState!.validate()) {
                            pgn(context, const Forms());
                          }
                        },
                        isTxt: true,
                        text: 'Register',
                        clr: bg,
                        rd: 69,
                        sz: 23,
                        up: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("I'm already "),
                          TextButton(
                            style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              pgx(context, const Login());
                              RegisterCubit.get(context).clearBtn();
                            },
                            child: const Text("a Bridgelt member..."),
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
