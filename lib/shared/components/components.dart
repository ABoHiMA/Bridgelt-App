// ignore_for_file: invalid_required_positional_param, constant_identifier_names, non_constant_identifier_names

import 'dart:io';

import 'package:bridgelt/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

double sz = 36.0;
Color wt = Colors.white;
Color bk = Colors.black;
Color gy = Colors.grey;
final dk = Colors.grey[900];
Icon back = const Icon(Icons.arrow_back_ios_new_outlined, size: 18);
var picker = ImagePicker();

Widget backBtn(context) => IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 18,
      ),
    );

enum ToastStates { SUCC, ERR, WRN }

Color ToastColor(ToastStates state) {
  Color clr;
  switch (state) {
    case ToastStates.SUCC:
      clr = Colors.greenAccent;
      break;
    case ToastStates.ERR:
      clr = Colors.redAccent;
      break;
    case ToastStates.WRN:
      clr = Colors.orangeAccent;
      break;
  }
  return clr;
}

void msg({
  required String msg,
  required ToastStates bg,
  Color txtClr = Colors.white,
  double txtSz = 18.0,
  ToastGravity grv = ToastGravity.BOTTOM,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: grv,
    timeInSecForIosWeb: 1,
    backgroundColor: ToastColor(bg),
    textColor: txtClr,
    fontSize: txtSz,
  );
}

Future<void> url({required String link}) async {
  if (await canLaunchUrl(Uri.parse("https://$link"))) {
    await launchUrl(Uri.parse("https://$link"));
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> urlcall({required String phone}) async {
  final Uri smsLaunchUri = Uri(
    scheme: 'tel',
    path: phone,
  );
  if (await canLaunchUrl(smsLaunchUri)) {
    await launchUrl(smsLaunchUri);
  } else {
    throw 'Could not launch $smsLaunchUri';
  }
}

Future<void> urlMail({required String mail}) async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: mail,
    query: encodeQueryParameters(<String, String>{
      'subject': 'Example Subject & Symbols are allowed!',
    }),
  );
  launchUrl(emailLaunchUri);
}

void pgn(
  context,
  @required Widget nextPage,
) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );

// void pgn(
//   context,
//   @required Widget nextPage,
// ) =>
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         transitionDuration: const Duration(seconds: 1),
//         transitionsBuilder:
//             (context, animation, secondaryAnimationtext, child) {
//           animation = CurvedAnimation(parent: animation, curve: Curves.linear);
//           return SlideTransition(
//             position:
//                 Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
//                     .animate(animation),
//             child: child,
//           );
//         },
//         pageBuilder: ((context, animation, secondaryAnimation) {
//           return nextPage;
//         }),
//       ),
//     );

void pgx(
  context,
  @required Widget nextPage,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
      (route) => false,
    );

PreferredSizeWidget bar({
  required BuildContext context,
  Widget? bar,
  Widget? ld,
  List<Widget>? ic,
  String? text,
  bool txt = true,
  bool cntr = false,
  bool bd = false,
}) =>
    AppBar(
      title: txt
          ? Text(
              text!,
              style: TextStyle(
                fontWeight: bd ? FontWeight.bold : FontWeight.w400,
              ),
            )
          : bar,
      centerTitle: cntr,
      leading: ld = IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      actions: ic,
      titleSpacing: 0.0,
    );

Future<void> imgPicker({
  required ImageSource imgSource,
  required File imgFile,
  required String imgName,
}) async {
  final pickedFile = await picker.pickImage(
    source: imgSource,
  );

  if (pickedFile != null) {
    imgFile = File(pickedFile.path);
    imgName = basename(imgFile.path);
  }
}

Future<void> imgPickerOptions({
  required BuildContext context,
  // required File imgFile,
  // required String imgName,
  required Future<void> functionCam,
  required Future<void> functionGellary,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: txt(
                  context: context,
                  txt: "Open from",
                  bd: true,
                  isClr: true,
                  sz: 18,
                ),
              ),
              const SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      functionCam;
                      // imgPicker(
                      //   imgSource: ImageSource.camera,
                      //   imgFile: imgFile,
                      //   imgName: imgName,
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            size: 36,
                          ),
                          const SizedBox(height: 9),
                          txt(
                            context: context,
                            txt: "Camera",
                            sz: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 23),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      functionGellary;
                      // imgPicker(
                      //   imgSource: ImageSource.gallery,
                      //   imgFile: imgFile,
                      //   imgName: imgName,
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.photo_library_outlined,
                            size: 36,
                          ),
                          const SizedBox(height: 9),
                          txt(
                            context: context,
                            txt: "Gallery",
                            sz: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget txt({
  required context,
  required String txt,
  double sz = 18,
  double spc = 1,
  bool bd = false,
  bool isClr = false,
  bool fi = false,
  bool st = true,
  Color clr = Colors.grey,
}) =>
    Text(
      txt,
      style: GoogleFonts.lato(
        color: isClr ? clr : Theme.of(context).textTheme.bodyLarge!.color,
        fontWeight: bd ? FontWeight.bold : FontWeight.w400,
        fontSize: sz,
        fontStyle: fi ? FontStyle.italic : FontStyle.normal,
        height: 1.13,
        letterSpacing: spc,
      ),
      maxLines: 20,
      overflow: TextOverflow.ellipsis,
      textAlign: st ? TextAlign.start : TextAlign.center,
    );

Widget btn({
  required Function() fun,
  String? text,
  final Widget? input,
  int mx = 3,
  double sz = 18,
  double rd = 13,
  double pd = 0,
  double ht = 43,
  double wd = double.infinity,
  Color clr = Colors.blueGrey,
  Color clrtxt = Colors.white,
  bool up = true,
  bool isTxt = true,
}) =>
    Container(
      padding: EdgeInsets.all(pd),
      width: wd,
      height: ht,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rd),
        color: clr,
      ),
      child: MaterialButton(
        onPressed: fun,
        minWidth: 1.0,
        child: isTxt
            ? Text(
                up ? text!.toUpperCase() : text!,
                style: TextStyle(
                  color: clrtxt,
                  fontWeight: FontWeight.bold,
                  fontSize: sz,
                ),
                maxLines: mx,
              )
            : input,
      ),
    );

Widget tff({
  required String txt,
  required IconData icon,
  required TextEditingController ctrl,
  required TextInputType type,
  String? Function(String?)? vld,
  final Widget? sx,
  final IconData? icSfx,
  final Function()? sfx,
  final Function()? tb,
  final Function(String)? smt,
  final Function(String)? chg,
  bool nbl = true,
  bool pss = false,
  bool isSfx = true,
  bool isPfx = true,
  double brdr = 69,
  double ht = 13,
  int? mx,
  int? ln = 1,
  context,
}) =>
    TextFormField(
      style: const TextStyle(),
      enabled: nbl,
      controller: ctrl,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: ht,
          horizontal: 13,
        ),
        prefixIcon: isPfx
            ? Icon(
                icon,
                color: bg,
              )
            : null,
        suffixIcon: isSfx
            ? IconButton(
                onPressed: sfx,
                icon: Icon(
                  icSfx,
                  color: bg,
                ),
              )
            : null,
        suffix: isSfx ? sx : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(brdr),
          borderSide: BorderSide(
            color: bg,
          ),
        ),
        labelText: txt,
        labelStyle: TextStyle(
          color: gy,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(brdr),
          borderSide: BorderSide(
            color: bg,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: bg,
        ),
      ),
      validator: vld,
      onFieldSubmitted: smt,
      onChanged: chg,
      keyboardType: type,
      onTap: tb,
      obscureText: pss,
      maxLength: mx,
      maxLines: ln,
    );

ThemeData thml() => ThemeData(
      useMaterial3: true,
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
      scaffoldBackgroundColor: wt,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: wt,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: bk,
          fontSize: 23,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: wt,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: bk,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        bodySmall: TextStyle(
          color: gy,
        ),
      ),
      iconTheme: IconThemeData(
        color: gy,
      ),
    );

ThemeData thmd() => ThemeData(
      useMaterial3: true,
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
      scaffoldBackgroundColor: dk,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: dk,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: wt,
          fontSize: 23,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: dk,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: dk,
        unselectedItemColor: wt,
        selectedItemColor: Colors.deepPurpleAccent,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(wt),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: wt,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        bodySmall: TextStyle(
          color: wt,
        ),
      ),
      iconTheme: IconThemeData(
        color: gy,
      ),
      cardTheme: CardTheme(
        surfaceTintColor: bg,
        shadowColor: bg,
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
