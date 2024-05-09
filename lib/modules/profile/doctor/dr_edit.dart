import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDoctorProfile extends StatelessWidget {
  const EditDoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrlName = TextEditingController();
    var ctrlPhone = TextEditingController();
    var ctrlHospital = TextEditingController();
    var ctrlClinic = TextEditingController();
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppUpdateUserDataSuccState) {
          msg(
            msg: "Updated Successfully",
            bg: ToastStates.SUCC,
          );
          Navigator.pop(context);
          ctrlName.clear();
          ctrlPhone.clear();
          ctrlClinic.clear();
          ctrlHospital.clear();
          AppCubit.get(context).profileimage = null;
          AppCubit.get(context).name = false;
          AppCubit.get(context).phone = false;
          AppCubit.get(context).isEdit = true;
          AppCubit.get(context).getSessionsUpdated();
          AppCubit.get(context).getArchivedSessionsUpdated();
        }
      },
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        var drmodel = cubitApp.drModel;
        var profileImg = AppCubit.get(context).profileimage;
        String drName = ctrlName.text.isEmpty ? drmodel.name! : ctrlName.text;
        String drPhone =
            ctrlPhone.text.isEmpty ? drmodel.phone! : ctrlPhone.text;
        String drHospital = ctrlHospital.text.isEmpty
            ? drmodel.hospitalName!
            : ctrlHospital.text;
        String drClinic =
            ctrlClinic.text.isEmpty ? drmodel.clinicAddress! : ctrlClinic.text;

        var drImg = profileImg == null
            ? NetworkImage(drmodel.profileImage!)
            : FileImage(profileImg) as ImageProvider<Object>?;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                ctrlName.clear();
                ctrlPhone.clear();
                profileImg = null;
                AppCubit.get(context).name = false;
                AppCubit.get(context).phone = false;
                AppCubit.get(context).isEdit = true;
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 18,
              ),
            ),
            centerTitle: true,
            title: txt(context: context, txt: "Edit Profile", sz: 23),
            actions: [
              state is AppUpdateUserDataLoadingState
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.6),
                      child: SizedBox(
                        height: 29,
                        width: 29,
                        child: CircularProgressIndicator(color: bg),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        cubitApp.updateUserData();
                      },
                      child: txt(
                        context: context,
                        txt: "Update",
                        isClr: true,
                        bd: true,
                        clr: bg,
                      ),
                    ),
            ],
          ),
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Profile Picture",
                          bd: true,
                          sz: 23,
                        ),
                        TextButton(
                          onPressed: () {
                            cubitApp.chgProfileImg();
                          },
                          child: txt(
                            context: context,
                            txt: "Edit",
                            bd: true,
                            isClr: true,
                            clr: bg,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: drImg,
                        radius: 99,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        child: Divider()),
                    txt(
                      context: context,
                      txt: "Personal Info",
                      bd: true,
                      sz: 23,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Name:",
                          bd: true,
                          isClr: true,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Center(
                            child: cubitApp.name
                                ? TextFormField(
                                    style: const TextStyle(),
                                    controller: ctrlName,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(13),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.6),
                                        borderSide: BorderSide(
                                          color: bg,
                                        ),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        ctrlName.text = drmodel.name!;
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                  )
                                : txt(
                                    context: context,
                                    txt: drName,
                                    bd: true,
                                    isClr: true,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Phone:",
                          bd: true,
                          isClr: true,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Center(
                            child: cubitApp.phone
                                ? TextFormField(
                                    controller: ctrlPhone,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.6),
                                        borderSide: BorderSide(
                                          color: bg,
                                        ),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        ctrlPhone.text = drmodel.phone!;
                                      }
                                      if (val.length > 11) {
                                        ctrlPhone.text = drmodel.phone!;
                                      }
                                      if (val.length < 11) {
                                        ctrlPhone.text = drmodel.phone!;
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                  )
                                : txt(
                                    context: context,
                                    txt: drPhone,
                                    bd: true,
                                    isClr: true,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Hospital Name:",
                          bd: true,
                          isClr: true,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Center(
                            child: cubitApp.hospital
                                ? TextFormField(
                                    style: const TextStyle(),
                                    controller: ctrlHospital,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(13),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.6),
                                        borderSide: BorderSide(
                                          color: bg,
                                        ),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        ctrlHospital.text =
                                            drmodel.hospitalName!;
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                  )
                                : txt(
                                    context: context,
                                    txt: drHospital,
                                    bd: true,
                                    isClr: true,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Clinic Addrees:",
                          bd: true,
                          isClr: true,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Center(
                            child: cubitApp.clinic
                                ? TextFormField(
                                    style: const TextStyle(),
                                    controller: ctrlClinic,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(13),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.6),
                                        borderSide: BorderSide(
                                          color: bg,
                                        ),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        ctrlClinic.text =
                                            drmodel.clinicAddress!;
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                  )
                                : txt(
                                    context: context,
                                    txt: drClinic,
                                    bd: true,
                                    isClr: true,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: txt(
                        context: context,
                        txt: "To change your personal info\n contact us on",
                        bd: true,
                        st: false,
                        // isClr: true,
                      ),
                    ),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
