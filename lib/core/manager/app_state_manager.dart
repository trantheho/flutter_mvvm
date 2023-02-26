import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../data/datasources/local/local_data_source.dart';
import '../../domain/models/user_model.dart';

class AppStateManager extends InheritedNotifier<AppState> {
  AppStateManager({
    Key? key,
    required Widget child,
    required LocalDataSource localDataSource,
  }) : super(
          key: key,
          notifier: AppState(localDataSource),
          child: child,
        );

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateManager>()!.notifier!;
  }

}

class AppState extends ChangeNotifier {
  final LocalDataSource localDataSource;

  AppState(this.localDataSource) {
    initAppState();
  }

  bool _initialized = false;
  bool _firstLogin = true;
  UserModel? _userInfo;
  ThemeMode _theme = ThemeMode.light;
  Locale _locale = Locale(ui.window.locale.languageCode);

  bool get initialized => _initialized;

  bool get firstLogin => _firstLogin;

  UserModel? get currentUser => _userInfo;

  ThemeMode get themeMode => _theme;

  Locale get locale => _locale;

  Future<void> initAppState() async {
    final firstLoginValue = await localDataSource.getFirstLogin();
    final oldTheme = await localDataSource.getTheme();
    final currentLanguageCode = await localDataSource.getLocale();

    if (_firstLogin != firstLoginValue) {
      _firstLogin = firstLoginValue;
      notifyListeners();
    }
    if (_theme != oldTheme) _theme = oldTheme;
    if (_locale.languageCode != currentLanguageCode) _locale = Locale(currentLanguageCode);

    await checkLogin();
    if (!initialized) {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> checkLogin() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    _userInfo = null;
  }

  Future<void> updateFirstLogin() async {
    _firstLogin = false;
    notifyListeners();
    await localDataSource.updateFirstLogin(false);
  }

  Future<void> signIn(UserModel newUser) async {
    _userInfo = newUser;
    notifyListeners();
  }

  Future<void> signOut() async {
    _userInfo = null;
    notifyListeners();
  }

  void updateTheme(ThemeMode themeMode) {
    if (_theme != themeMode) {
      debugPrint('change theme $themeMode');
      _theme = themeMode;
      notifyListeners();
      localDataSource.updateTheme(themeMode.name);
    }
  }

  void updateLocale(Locale newLocale) {
    if (newLocale.languageCode != _locale.languageCode) {
      try {
        _locale = newLocale;
        notifyListeners();
        localDataSource.saveLocale(newLocale.languageCode);
      } catch (error) {
        throw StateError("update locale failed ${error.toString()}");
      }
    }
  }
}
