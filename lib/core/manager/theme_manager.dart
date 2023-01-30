import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/data/datasources/local/local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local/hive_storage.dart';

class ThemeManager{

  static final ThemeData light = ThemeData(
    primaryColor: AppColors.orange,
  );


  static final dark = ThemeData(
    primaryColor: Colors.black,
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
