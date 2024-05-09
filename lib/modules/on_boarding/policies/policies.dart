import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/network/local/cache_h.dart';
import 'package:flutter/material.dart';

class Policies extends StatefulWidget {
  const Policies({super.key});

  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  bool isChecked = false;
  void start() {
    CacheHelper.saveData(
      key: "start",
      val: true,
    ).then(
      (value) {
        pgx(context, const Login());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Image(
          image: AssetImage("assets/imgs/logo.png"),
          height: 49,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: txt(
                context: context,
                txt: "\nBridgelt Policies",
                bd: true,
                isClr: true,
                clr: bg,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      txt(
                        context: context,
                        txt: "• Privacy and Data Protection Policy",
                        bd: true,
                        sz: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: txt(
                          context: context,
                          txt:
                              "Personal Information: Strict guidelines on how personal information of both volunteers and individuals with special needs is collected, used, and stored.\nConsent: Ensure consent is obtained before sharing any personal information.\nData Security: Implement robust data protection measures to prevent unauthorized access, disclosure, alteration, or destruction of personal information.\n",
                          sz: 15,
                        ),
                      ),
                      txt(
                        context: context,
                        txt: "• Background Checks and Screening Policy",
                        bd: true,
                        sz: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: txt(
                          context: context,
                          txt:
                              "Volunteer Screening: Procedures for conducting background checks on volunteers to ensure the safety and well-being of individuals with special needs.\n",
                          sz: 15,
                        ),
                      ),
                      txt(
                        context: context,
                        txt: "•	Volunteer-Vetting Policy",
                        bd: true,
                        sz: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: txt(
                          context: context,
                          txt:
                              "References: Require volunteers to provide references that can attest to their character.\n",
                          sz: 15,
                        ),
                      ),
                      txt(
                        context: context,
                        txt:
                            "The app policy is that any agreement made outside the app, app is not responsible for it.\n",
                        bd: true,
                        sz: 18,
                        st: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  txt(
                    context: context,
                    txt: "I agree to all policies",
                    bd: true,
                  ),
                ],
              ),
            ),
          ),
          isChecked
              ? ElevatedButton(
                  onPressed: () {
                    start();
                  },
                  child: txt(
                    context: context,
                    txt: "Welcome",
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 13),
        ],
      ),
    );
  }
}
