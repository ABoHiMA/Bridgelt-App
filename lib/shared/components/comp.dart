import 'package:bridgelt/shared/components/components.dart';
import 'package:flutter/material.dart';

class BoardingModel {
  final String img;
  final String title;
  // final String body;

  BoardingModel({
    required this.img,
    required this.title,
    // required this.body,
  });
}

Widget brdItm(
  context,
  BoardingModel model,
) =>
    Column(
      children: [
        const SizedBox(height: 13),
        Expanded(
          child: Image(
            image: AssetImage(model.img),
          ),
        ),
        const SizedBox(height: 9),
        txt(
          context: context,
          txt: model.title,
          sz: 20,
          bd: true,
          st: false,
        ),
        // const SizedBox(height: 6),
        // txt(
        //   context: context,
        //   txt: model.body,
        //   isClr: true,
        //   sz: 18,
        //   bd: true,
        // ),
        const SizedBox(height: 3),
      ],
    );
