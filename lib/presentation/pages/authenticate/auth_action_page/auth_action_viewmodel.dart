import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/core/manager/app_state_manager.dart';
import 'package:flutter_mvvm/data/datasources/local/hive_storage.dart';
import 'package:flutter_mvvm/domain/models/account_model.dart';
import 'package:flutter_mvvm/domain/usecases/create_an_account_usecase.dart';
import 'package:flutter_mvvm/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authActionViewModel = StateNotifierProvider<AuthActionViewModel, AuthActionState>((ref) {
  final createAnAccountUseCase = ref.watch(createAnAccountUseCaseProvider);
  final loginUseCase = ref.watch(loginUserCaseProvider);

  return AuthActionViewModel(createAnAccountUseCase, loginUseCase, HiveStorage.instance,);
});

abstract class AuthActionState{}
class AuthActionInitState extends AuthActionState{}
class AuthActionCreatedAccountState extends AuthActionState{}
class AuthActionSwitchActionState extends AuthActionState{}

class AuthActionViewModel extends StateNotifier<AuthActionState>{
  // local datasource
  final HiveStorage localDataSource;
  final CreateAnAccountUseCase createAnAccountUseCase;
  final LoginUseCase loginUseCase;

  AuthActionViewModel(this.createAnAccountUseCase, this.loginUseCase,this.localDataSource,) : super(AuthActionInitState());


  Future<void> createAnAccount(AccountModel account) async {
    try{
      appController.loading.show();
      final result = await createAnAccountUseCase.run(account);
      if(result){
        appController.loading.hide();
        //save account to local datasource
        state = AuthActionCreatedAccountState();
      }
      else{
        appController.loading.hide();
      }
    }
    catch (e){
      appController.loading.hide();
    }
  }

  Future<void> login({required String email, required String password, required BuildContext context}) async {
    final appState = AppStateManager.of(context);
    try{
      appController.loading.show();
      final user = await loginUseCase.run(email: email, password: password);
      if(user != null){
        appState.signIn(user);
        appController.loading.hide();
      }
    }
    catch(e){
      appController.loading.hide();
    }
  }
}