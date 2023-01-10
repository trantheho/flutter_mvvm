import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/core/router/route_config.dart';
import 'package:flutter_mvvm/core/utils/app_assets.dart';
import 'package:flutter_mvvm/core/utils/app_helper.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key,}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppHelper.statusBarOverlayUI(Brightness.dark,),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(AppImages.onBoardingThree),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        S.of(context).description3,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bold.copyWith(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 34,),
                      Text(
                        S.of(context).lorem,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.normal.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 41,
                ),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildButton(){
    return Column(
      children: [
        Consumer(
          builder: (context, ref, _) {
            return AppButton(
              buttonColor: Colors.black,
              buttonText: S.of(context).createAnAccount.toUpperCase(),
              style: AppTextStyle.bold.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
              onPressed: () => toRegister(ref),
            );
          }
        ),
        const SizedBox(height: 18,),
        Consumer(
            builder: (context, ref, _) {
              return AppButton(
                buttonColor: Colors.white,
                borderColor: Colors.black,
                buttonText: S.of(context).login.toUpperCase(),
                style: AppTextStyle.bold.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                onPressed: () => toLogin(ref),
              );
            }
        ),
      ],
    );
  }

  void toLogin(WidgetRef ref){
    appController.router.of(context).goNamed(AppPage.authAction.name, params: {AppPage.authAction.params!: 'login'});
  }

  void toRegister(WidgetRef ref){
    appController.router.of(context).goNamed(AppPage.authAction.name, params: {AppPage.authAction.params!: 'register'});
  }
}
