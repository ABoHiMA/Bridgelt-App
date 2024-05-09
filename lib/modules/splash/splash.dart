import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: thmMode == 'Dark Mode' ? thmd() : thml(),
      child: splash(context),
    );
  }
}

Widget splash(context) => Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CircularPercentIndicator(
        radius: 137,
        animation: true,
        percent: 1.0,
        progressColor: bg,
        animationDuration: 1307,
        lineWidth: 13,
        center: const Image(
          color: null,
          fit: BoxFit.fill,
          height: 200,
          width: 200,
          image: AssetImage(
            'assets/imgs/bridgelt.png',
          ),
        ),
      ),
    );
