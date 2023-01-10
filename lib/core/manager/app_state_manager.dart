import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../data/datasources/local/hive_storage.dart';
import '../../data/datasources/local/local_data_source.dart';
import '../../domain/models/user_model.dart';

class AppStateManager extends InheritedNotifier<AppStateNotifier>{
  AppStateManager({
    Key? key,
    required Widget child,
  }) : super(
    key: key,
    notifier: AppStateNotifier(),
    child: child,
  );

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateManager>()!.notifier!.appState;
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

  @override
  void dispose() {
    appState.dispose();
    super.dispose();
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

  final StreamController<bool> _initializedStateController;
  final StreamController<bool> _firstLoginController;
  final StreamController<UserModel?> _userStreamController;

  Stream<bool> get onInitializedStateChange => _initializedStateController.stream;
  Stream<bool> get onFirstLoginChange => _firstLoginController.stream;
  Stream<UserModel?> get onCurrentUserChanged => _userStreamController.stream;

  bool _initialized = false;
  bool _firstLogin = true;
  UserModel? _currentUser;

  bool get initialized => _initialized;
  bool get firstLogin => _firstLogin;
  UserModel? get currentUser => _currentUser;


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

  void dispose(){
    _initializedStateController.close();
    _firstLoginController.close();
    _userStreamController.close();
  }
}

