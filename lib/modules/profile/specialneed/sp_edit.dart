import 'package:bridgelt/shared/components/components.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:bridgelt/shared/cubit/cubit.dart';
import 'package:bridgelt/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditSpecialNeedProfile extends StatelessWidget {
  const EditSpecialNeedProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrlName = TextEditingController();
    var ctrlPhone = TextEditingController();
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
          AppCubit.get(context).profileimage = null;
          AppCubit.get(context).name = false;
          AppCubit.get(context).phone = false;
          AppCubit.get(context).gov = false;
          AppCubit.get(context).isEdit = true;
          AppCubit.get(context).getArchivedCasesUpdated();
          AppCubit.get(context).getSpCasesUpdated();
        }
      },
      builder: (context, state) {
        var cubitApp = AppCubit.get(context);
        var spmodel = cubitApp.spModel;
        var profileImg = AppCubit.get(context).profileimage;
        String spName = ctrlName.text.isEmpty ? spmodel.name! : ctrlName.text;
        String spPhone =
            ctrlPhone.text.isEmpty ? spmodel.phone! : ctrlPhone.text;
        var spImg = profileImg == null
            ? NetworkImage(spmodel.profileImage!)
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
                AppCubit.get(context).gov = false;
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
                        if (cubitApp.name) {
                          cubitApp.chgName();
                          spName = ctrlName.text;
                        }
                        if (cubitApp.phone) {
                          cubitApp.chgPhone();
                          spPhone = ctrlPhone.text;
                        }
                        cubitApp.updateUserData(
                          name: spName,
                          phone: spPhone,
                          specialNeedGovernorate: cubitApp.selectedGov!,
                          specialNeedCity: cubitApp.selectedCity!,
                        );
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
                        backgroundImage: spImg,
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
                          clr: bg,
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
                                        ctrlName.text = spmodel.name!;
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                  )
                                : txt(
                                    context: context,
                                    txt: spName,
                                    bd: true,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          child: cubitApp.name
                              ? IconButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      cubitApp.chgName();
                                      spName = ctrlName.text;
                                    }
                                  },
                                  icon: const Icon(Icons.done_outline),
                                )
                              : IconButton(
                                  onPressed: () {
                                    cubitApp.chgName();
                                    ctrlName.text = spName;
                                  },
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Phone:",
                          bd: true,
                          isClr: true,
                          clr: bg,
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
                                        ctrlPhone.text = spmodel.phone!;
                                      }
                                      if (val.length > 11) {
                                        ctrlPhone.text = spmodel.phone!;
                                      }
                                      if (val.length < 11) {
                                        ctrlPhone.text = spmodel.phone!;
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.phone,
                                  )
                                : txt(
                                    context: context,
                                    txt: spPhone,
                                    bd: true,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          child: cubitApp.phone
                              ? IconButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      cubitApp.chgPhone();
                                      spPhone = ctrlPhone.text;
                                    }
                                  },
                                  icon: const Icon(Icons.done_outline),
                                )
                              : IconButton(
                                  onPressed: () {
                                    cubitApp.chgPhone();
                                    ctrlPhone.text = spPhone;
                                  },
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Your governorate and city",
                          bd: true,
                          sz: 18,
                        ),
                        TextButton(
                          onPressed: () {
                            cubitApp.chgGov();
                          },
                          child: txt(
                            context: context,
                            txt: cubitApp.isEdit ? "Edit" : "Done",
                            bd: true,
                            isClr: true,
                            clr: bg,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Your governorate: ",
                          bd: true,
                          isClr: true,
                          clr: bg,
                        ),
                        Container(
                          child: cubitApp.gov
                              ? DropdownButton<String>(
                                  value: AppCubit.get(context).selectedGov,
                                  onChanged: (String? newValue) {
                                    AppCubit.get(context).choiseGov(newValue);
                                  },
                                  items: governorate.keys.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              : txt(
                                  context: context,
                                  txt: cubitApp.selectedGov!,
                                  bd: true,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txt(
                          context: context,
                          txt: "Your city: ",
                          bd: true,
                          isClr: true,
                          clr: bg,
                        ),
                        Container(
                          child: cubitApp.gov
                              ? DropdownButton<String>(
                                  value: AppCubit.get(context).selectedCity,
                                  onChanged: (String? newValue) {
                                    AppCubit.get(context).selectedCity =
                                        newValue!;
                                    AppCubit.get(context).dropdown(newValue);
                                  },
                                  items: governorate[
                                          AppCubit.get(context).selectedGov]!
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              : txt(
                                  context: context,
                                  txt: cubitApp.selectedCity!,
                                  bd: true,
                                ),
                        ),
                      ],
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
