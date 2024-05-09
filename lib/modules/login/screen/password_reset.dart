import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  @override
  Widget build(BuildContext context) {
    var ctrlMail = TextEditingController();
    var formkey = GlobalKey<FormState>();

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
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              txt(
                context: context,
                txt: "Reset Your Password",
                sz: 30,
              ),
              const SizedBox(height: 23),
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
              const SizedBox(height: 23),
              btn(
                fun: () {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: ctrlMail.text)
                          .then((value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: txt(
                                  context: context,
                                  txt: "Successfull",
                                  bd: true),
                              content: txt(
                                  context: context,
                                  txt:
                                      "Password reset email sent successfully"),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    pgx(context, const Login());
                                  },
                                  child: const Text("Done"),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    });
                  }
                },
                isTxt: true,
                text: 'Reset Password',
                clr: bg,
                rd: 69,
                sz: 23,
                ht: 55,
                up: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
