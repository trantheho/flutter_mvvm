import 'package:flutter/src/material/app.dart';
import 'package:flutter_mvvm/data/datasources/local/local_data_source.dart';

class MockLocalDataSource extends LocalDataSource{
  @override
  Future<String> getAccessToken() async {
    return '';
  }

  @override
  Future<bool> getFirstLogin() async {
    return true;
  }

  @override
  Future<String> getLocale() async {
    return 'vi';
  }

  @override
  Future<ThemeMode> getTheme() async {
    return ThemeMode.light;
  }

  @override
  Future<void> removeAccessToken() async {

  }

  @override
  Future<void> saveAccessToken(String token) async {

  }

  @override
  Future<void> saveLocale(String languageCode) async {
  }

  @override
  Future<void> updateFirstLogin(bool value) async {
  }

  @override
  Future<void> updateTheme(String mode) async {

  }
}