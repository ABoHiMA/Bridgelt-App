import 'package:bridgelt/shared/cubit/bridgelt/states.dart';
import 'package:bridgelt/shared/network/local/cache_h.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BridgeltCubit extends Cubit<BridgeltStates> {
  BridgeltCubit() : super(BridgeltInitState());
  static BridgeltCubit get(context) => BlocProvider.of(context);

  String? selectedThm = "System Default";
  ThemeMode? themeMode = ThemeMode.system;
  
  void chgMode(String? ae) {
    selectedThm = ae;
    if (ae == 'Light Mode') {
      themeMode = ThemeMode.light;
      CacheHelper.saveData(
        key: 'themeMode',
        val: 'Light Mode',
      );
      emit(BridgeltModeState());
    } else if (ae == 'Dark Mode') {
      themeMode = ThemeMode.dark;
      CacheHelper.saveData(
        key: 'themeMode',
        val: 'Dark Mode',
      );
      emit(BridgeltModeState());
    } else {
      themeMode = ThemeMode.system;
      CacheHelper.saveData(
        key: 'themeMode',
        val: 'System Default',
      );
      emit(BridgeltModeState());
    }
    emit(BridgeltModeState());
  }
  
}
