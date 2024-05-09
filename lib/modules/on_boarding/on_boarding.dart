// ignore_for_file: avoid_print, must_be_immutable

import 'package:bridgelt/modules/on_boarding/policies/policies.dart';
import 'package:bridgelt/shared/components/comp.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var brdCtrl = PageController();
  bool isLast = false;
  bool isFirst = true;

  List<BoardingModel> boarding = [
    BoardingModel(
      img: "assets/imgs/01.png",
      title: "No disability with willpower",
    ),
    BoardingModel(
      img: "assets/imgs/02.png",
      title: "Capables, but with a difference",
    ),
    BoardingModel(
      img: "assets/imgs/03.png",
      title: "Together, we challenge disability",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Image(
          image: AssetImage("assets/imgs/logo.png"),
          height: 49,
        ),
        actions: isLast
            ? null
            : [
                TextButton(
                  onPressed: () {
                    pgx(context, const Policies());
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: bg,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.6),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: brdCtrl,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                      isFirst = false;
                    });
                    // print("LAST");
                  } else if (index == 0) {
                    setState(() {
                      isFirst = true;
                      isLast = false;
                    });
                    // print("FIRST");
                  } else {
                    setState(() {
                      isFirst = false;
                      isLast = false;
                    });
                    // print("AE -- $isFirst -- $isLast");
                  }
                },
                itemBuilder: (context, inx) => brdItm(
                  context,
                  boarding[inx],
                ),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: isFirst
                        ? null
                        : IconButton(
                            onPressed: () {
                              brdCtrl.previousPage(
                                duration: const Duration(
                                  milliseconds: 1307,
                                ),
                                curve: Curves.easeInOutCirc,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: bg,
                            ),
                          ),
                  ),
                  SmoothPageIndicator(
                    controller: brdCtrl,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 6,
                      dotColor: bg,
                      activeDotColor: bg,
                    ),
                  ),
                  Container(
                    child: isLast
                        ? TextButton(
                            onPressed: () {
                              pgx(context, const Policies());
                            },
                            child: txt(
                              context: context,
                              txt: "Next",
                              isClr: true,
                              clr: bg,
                              bd: true,
                              sz: 18,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              brdCtrl.nextPage(
                                duration: const Duration(
                                  milliseconds: 1307,
                                ),
                                curve: Curves.easeInOutCirc,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: bg,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13.7),
          ],
        ),
      ),
    );
  }
}
