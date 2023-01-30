import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/datasources/local/local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

import '../../data/datasources/local/hive_storage.dart';

final localeInit = FutureProvider<String?>((ref) async => await HiveStorage.instance.getLocale());

final localeProvider = StateNotifierProvider<LocaleManager, Locale>((ref){

  final languageCode = ref.watch(localeInit).value;
  final locale = Locale(languageCode ?? ui.window.locale.languageCode);

  return LocaleManager(HiveStorage.instance, locale);
});

class LocaleManager extends StateNotifier<Locale> {
  LocalDataSource localDataSource;
  final Locale initLocale;

  LocaleManager(this.localDataSource, this.initLocale) : super(initLocale);

  Future<void> updateLocale(Locale newLocale) async {
    try{
      await localDataSource.saveLocale(newLocale.languageCode);
      state = newLocale;
    }
    catch(error){
      throw StateError("update locale failed ${error.toString()}");
    }
  }
}