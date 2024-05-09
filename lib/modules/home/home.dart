import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is AppLoadingGetUserDataState,
          builder: (context) =>
              Center(child: CircularProgressIndicator(color: bg)),
          fallback: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings,
                color: gy,
                size: 40,
              ),
              const SizedBox(height: 13),
              Center(
                child: txt(
                  context: context,
                  txt: "Your account is under process \n\n by Bridgelt Team",
                  bd: true,
                  sz: 23,
                  st: false,
                  isClr: true,
                ),
              ),
              const SizedBox(height: 69),
              msgTeam != ""
                  ? Column(
                      children: [
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 40,
                        ),
                        Center(
                          child: txt(
                            context: context,
                            txt:
                                "$msgTeam \n\n Contact us with our email in about page",
                            bd: true,
                            sz: 20,
                            st: false,
                            isClr: true,
                            clr: Colors.red,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
