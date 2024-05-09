// ignore_for_file: avoid_print

import 'package:bridgelt/modules/login/cubit/login_states.dart';
import 'package:bridgelt/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool pass = true;
  IconData passIc = Icons.visibility_off_outlined;
  DocumentSnapshot? documentSnapshot;

  void passVisible() {
    pass = !pass;
    if (pass) {
      passIc = Icons.visibility_off_outlined;
    } else {
      passIc = Icons.visibility_outlined;
    }
    emit(LoginPassVisibleState());
  }

  void userLogin({
    required String email,
    required String pass,
  }) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then(
      (value) {
        print("SUCC LOGIN ${value.user!.uid}");
        uId = value.user!.uid;
        print("============================$uId");
        emit(LoginSuccState(value.user!.uid));
      },
    ).catchError(
      (error) {
        print("Login Error = ${error.toString()}");
        emit(LoginErrState(error.toString()));
      },
    );
  }
  
}
