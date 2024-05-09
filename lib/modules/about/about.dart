import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            pgx(context, const Bridgelt());
            index = 0;
          },
          icon: back,
        ),
        centerTitle: true,
        title: txt(context: context, txt: "About US", sz: 23),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: txt(
                context: context,
                txt: "Bridgelt Team",
                bd: true,
                sz: 39,
              ),
            ),
          ),
          txt(context: context, txt: "Contact Us"),
          Center(
            child: TextButton(
              onPressed: () {
                urlMail(mail: bridgeltMail);
              },
              child: txt(
                context: context,
                txt: bridgeltMail,
                bd: true,
                st: false,
                isClr: true,
                clr: bg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
