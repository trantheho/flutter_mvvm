import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/core/router/route_config.dart';
import 'package:flutter_mvvm/core/utils/app_helper.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/domain/models/account_model.dart';
import 'package:flutter_mvvm/presentation/pages/authenticate/auth_action_page/auth_action_viewmodel.dart';
import 'package:flutter_mvvm/presentation/pages/authenticate/auth_action_page/auth_layout/register_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_layout/login_layout.dart';

enum AuthAction {
  register,
  login,
}

class AuthActionPage extends StatefulWidget {
  final AuthAction authAction;

  const AuthActionPage({
    Key? key,
    required this.authAction,
  }) : super(key: key);

  @override
  State<AuthActionPage> createState() => _AuthActionPageState();
}

class _AuthActionPageState extends State<AuthActionPage> {
  late final ValueNotifier<AuthAction> actionNotifier;
  String registerEmail = '';
  String registerPassword = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    actionNotifier = ValueNotifier(widget.authAction);
  }

  @override
  void dispose() {
    actionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => appController.helper.hideKeyboard(context),
      child: AnnotatedRegion(
        value: appController.helper.statusBarOverlayUI(Brightness.light),
        child: Scaffold(
          body: Consumer(
            builder: (_, ref, __) {
              final authActionVM = ref.read(authActionViewModel.notifier);
              ref.listen<AuthActionState>(authActionViewModel, (_, state) => listenState(state));

              return ValueListenableBuilder<AuthAction>(
                valueListenable: actionNotifier,
                builder: (_, action, __) {
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(action == AuthAction.login
                                  ? AppImages.loginPlaceholder
                                  : AppImages.registerPlaceholder,),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: SafeArea(
                            bottom: false,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 10,
                                  top: 10,
                                  child: IconButton(
                                    onPressed: onBack,
                                    icon: Image.asset(
                                      AppImages.leftArrow,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    height: 20,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      buildLayout(action, authActionVM),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildLayout(AuthAction action, AuthActionViewModel authActionVM) {
    switch (action) {
      case AuthAction.register:
        return RegisterLayout(
          onFirstNameChange: (value) => firstName = value,
          onLastNameChange: (value) => lastName = value,
          onRegisterEmailChange: (value) => registerEmail = value,
          onRegisterPasswordChange: (value) => registerPassword = value,
          onClear: clearRegisterData,
          onCreateAnAccount: () {
            appController.helper.hideKeyboard(context);

            final account = AccountModel(
              firstName: firstName,
              lastName: lastName,
              email: email,
              password: password,
            );

            authActionVM.createAnAccount(account);
          },
        );
      case AuthAction.login:
        return LoginLayout(
          onLogin: (){
            appController.helper.hideKeyboard(context);
            authActionVM.login(email: email, password: password, context: context);
          },
        );
    }
  }

  void listenState(AuthActionState state) {
    if (state is AuthActionCreatedAccountState) {
      appController.dialog.showCreatedAccountDialog(
        context: context,
        fullName: '$firstName $lastName',
        onSignIn: () {
          actionNotifier.value = AuthAction.login;
          context.goNamed(
            AppPage.authAction.name,
            params: {
              AppPage.authAction.params!: AuthAction.login.name,
            },
          );
        },
      );
    }
  }

  void onBack() {
    context.go(AppPage.auth.path);
  }

  void clearRegisterData() {
    firstName = '';
    lastName = '';
    registerEmail = '';
    registerPassword = '';
  }
}
