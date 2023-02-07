import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/data/datasources/local/local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/hive_storage.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    primaryColor: AppColors.orange,
    backgroundColor: Colors.white,
    primaryColorLight: Colors.black,
    textTheme: TextTheme(
      displaySmall: AppTextStyle.normal.copyWith(
        color: Colors.black,
      ),
      displayMedium: AppTextStyle.medium.copyWith(
        color: Colors.black,
      ),
      displayLarge: AppTextStyle.bold.copyWith(
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    bottomAppBarColor: Colors.white,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.grey177,
    ),
  );

  static final dark = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: Colors.black54,
    primaryColorLight: Colors.orange,
    textTheme: TextTheme(
      displaySmall: AppTextStyle.normal.copyWith(
        color: Colors.white,
      ),
      displayMedium: AppTextStyle.medium.copyWith(
        color: Colors.white,
      ),
      displayLarge: AppTextStyle.bold.copyWith(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    bottomAppBarColor: Colors.black54,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
    ),
  );
}

/*
final themeInit = FutureProvider<ThemeMode>((ref) async => await HiveStorage.instance.getTheme());

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>((ref){

  //final theme = ref.watch(themeInit).value!;

  return ThemeProvider(ThemeMode.light, HiveStorage.instance);
});


class ThemeProvider extends StateNotifier<ThemeMode>{
  final ThemeMode initThemeMode;
  final LocalDataSource localDataSource;

  ThemeProvider(this.initThemeMode, this.localDataSource)  : super(initThemeMode);


  Future<void> updateTheme(ThemeMode themeMode) async {
    try{
      await localDataSource.updateTheme(themeMode.name);
      state = themeMode;
    }
    catch (e){
      throw StateError("update theme failed with ${e.toString()}");
    }
  }
}*/
