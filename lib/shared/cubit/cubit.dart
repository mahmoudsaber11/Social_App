// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitailState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDarkMode = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDarkMode = fromShared;
      emit(AppChangeModeState());
    } else {
      isDarkMode = !isDarkMode;
      CacheHelper.saveData(key: 'isDarkMode', value: isDarkMode).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
