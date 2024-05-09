// ignore_for_file: avoid_print

// import 'package:bridgelt/layout/bridglet_layout.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bridgelt/firebase_options.dart';
import 'package:bridgelt/modules/register/cubit/register_cubit.dart';
import 'package:bridgelt/modules/login/cubit/login_cubit.dart';
import 'package:bridgelt/modules/login/screen/login.dart';
import 'package:bridgelt/modules/on_boarding/on_boarding.dart';
import 'package:bridgelt/modules/splash/splash.dart';
import 'package:bridgelt/shared/bloc-observer.dart';
import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/bridgelt/cubit.dart';
import 'package:bridgelt/shared/cubit/bridgelt/states.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/network/local/cache_h.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> bgn(RemoteMessage msg) async {
  print('message BGN------! ${msg.data.toString()}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onMessage.listen((event) {
    print('on message-----! ${event.data.toString()}');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('message app------! ${event.data.toString()}');
  });
  FirebaseMessaging.onBackgroundMessage(bgn);

  onBoarding = CacheHelper.getData(key: "start");
  thmMode = CacheHelper.getData(key: "themeMode");
  uId = CacheHelper.getData(key: 'uId');
  userType = CacheHelper.getData(key: 'userType');
  verify = CacheHelper.getData(key: 'verify');
  fPrint = CacheHelper.getData(key: 'fingerprint') ?? "";

  Widget startApp;
  if (onBoarding != null) {
    startApp = const Login();
  } else {
    startApp = const OnBoarding();
  }

  // if (onBoarding != null) {
  //   if (uId != null) {
  //     startApp = const Bridgelt();
  //   } else {
  //     startApp = const Login();
  //   }
  // } else {
  //   startApp = const OnBoarding();
  // }

  runApp(MyApp(startApp: startApp, thmMode: thmMode));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startApp, required this.thmMode});
  final Widget startApp;
  final String? thmMode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BridgeltCubit()..chgMode(thmMode),
        ),
        BlocProvider(
          create: (context) => AppCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: BlocConsumer<BridgeltCubit, BridgeltStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bridgelt',
            theme: thml(),
            darkTheme: thmd(),
            themeMode: BridgeltCubit.get(context).themeMode,
            home: AnimatedSplashScreen(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              duration: 999,
              splashIconSize: 300,
              splash: const SplashScreen(),
              nextScreen: startApp,
            ),
          );
        },
      ),
    );
  }
}
