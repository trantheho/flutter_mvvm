import 'dart:ui' as ui;

import 'package:flutter_mvvm/data/datasources/local/local_data_source.dart';
import 'package:hive/hive.dart';

//final hiveProvider = Provider((ref) => HiveStorage.instance);

class HiveStorage implements LocalDataSource{
  HiveStorage._private();
  static final instance = HiveStorage._private();

  @override
  Future<String> getAccessToken() async {
    final box = await Hive.openBox<String>('token');
    final String? accessToken = box.get('accessToken');
    return accessToken ?? '';
  }

  @override
  Future<void> saveAccessToken(String token) async {
    final box = await Hive.openBox<String>('token');
    await box.put('accessToken', token);
  }

  @override
  Future<void> removeAccessToken() async {
    final box = await Hive.openBox<String>('token');
    await box.put('accessToken', '');
  }

  @override
  Future<void> saveLocale(String languageCode) async {
    final box = await Hive.openBox<String>('locale');
    await box.put('languageCode', languageCode);
  }

  @override
  Future<String> getLocale() async {
    final box = await Hive.openBox<String>('locale');
    final String? code = box.get('languageCode');
    return code ?? ui.window.locale.languageCode;
  }

  @override
  Future<bool> getFirstLogin() async {
    final box = await Hive.openBox<bool>('firstLogin');
    final bool? code = box.get('firstLogin');
    return code ?? true;
  }

  @override
  Future<void> updateFirstLogin(bool value) async {
    final box = await Hive.openBox<bool>('firstLogin');
    await box.put('firstLogin', value);
  }
}