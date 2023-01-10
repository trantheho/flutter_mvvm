import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/datasources/local/hive_storage.dart';
import 'package:flutter_mvvm/data/datasources/local/local_data_source.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/error/error_page.dart';
import 'route_config.dart';

class AppRouter{
  final GoRouter _goRouter;
  GoRouter get goRouter => _goRouter;

  AppRouter()
      : _goRouter = GoRouter(
          debugLogDiagnostics: true,
          initialLocation: AppPage.root.path,
          navigatorKey: RouteConfig.rootKey,
          redirect: RouteConfig.guard,
          errorBuilder: (_, state) => ErrorPage(
            error: state.error.toString(),
          ),
          routes: [
            RouteConfig.buildRoute(AppPage.onBoarding),
            RouteConfig.buildRoute(AppPage.auth),
            ShellRoute(
              builder: (_, state, child) => RouteConfig.initPage(_, state, child),
              navigatorKey: RouteConfig.nestedKey,
              routes: [
                RouteConfig.buildRoute(AppPage.root),
                RouteConfig.buildRoute(AppPage.home),
                RouteConfig.buildRoute(AppPage.category),
                RouteConfig.buildRoute(AppPage.cart),
                RouteConfig.buildRoute(AppPage.favorite),
                RouteConfig.buildRoute(AppPage.profile),
              ],
            ),
          ],
        );

  GoRouter of(BuildContext context) => GoRouter.of(context);

  void pop() => _goRouter.location != AppPage.root.path ? _goRouter.pop() : null;
}

class AppStateScope extends InheritedNotifier<AppStateNotifier> {
  AppStateScope({
    Key? key,
    required Widget child,
  }) : super(
          key: key,
          notifier: AppStateNotifier(),
          child: child,
        );

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.notifier!.appState;
  }
}

class AppStateNotifier extends ChangeNotifier {
  final AppState appState;

  AppStateNotifier() : appState = AppState(HiveStorage.instance) {
    appState.initAppState();
    appState.onInitializedStateChange.listen((_) => notifyListeners());
    appState.onCurrentUserChanged.listen((_) => notifyListeners());
    appState.onFirstLoginChange.listen((_) => notifyListeners());
  }
}

class AppState {
  final LocalDataSource localDataSource;

  AppState(this.localDataSource)
      : _initializedStateController = StreamController<bool>.broadcast(),
        _userStreamController = StreamController<UserModel?>.broadcast(),
        _firstLoginController = StreamController<bool>.broadcast()
  {
    _initializedStateController.stream.distinct().listen((state) {
      debugPrint('state change');
      _initialized = state;
    });
    _userStreamController.stream.distinct().listen((UserModel? currentUser) {
      debugPrint('user change');
      _currentUser = currentUser;
    });
    _firstLoginController.stream.distinct().listen((bool value) {
      debugPrint('first login change');
      _firstLogin = value;
    });
  }

  Stream<bool> get onInitializedStateChange => _initializedStateController.stream;
  final StreamController<bool> _initializedStateController;

  Stream<UserModel?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<UserModel?> _userStreamController;

  Stream<bool> get onFirstLoginChange => _firstLoginController.stream;
  final StreamController<bool> _firstLoginController;

  bool _initialized = false;
  bool get initialized => _initialized;

  bool _firstLogin = true;
  bool get firstLogin => _firstLogin;

  UserModel? get currentUser => _currentUser;
  UserModel? _currentUser;


  Future<void> initAppState() async {
    final value = await localDataSource.getFirstLogin();
    _firstLoginController.add(value);
    await checkLogin();
    if (!initialized) {
      _initializedStateController.add(true);
    }
  }

  Future<void> checkLogin() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    _userStreamController.add(null);
  }

  Future<void> updateFirstLogin() async {
    _firstLoginController.add(false);
    await localDataSource.updateFirstLogin(false);
  }

  Future<void> signIn(UserModel newUser) async {
    _userStreamController.add(newUser);
  }

  Future<void> signOut() async {
    _userStreamController.add(null);
  }
}