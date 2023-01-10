import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_assets.dart';
import 'package:flutter_mvvm/core/utils/app_validation.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
import 'package:flutter_mvvm/presentation/widgets/input.dart';

class LoginLayout extends StatefulWidget {
  final Function()? onLogin;
  const LoginLayout({Key? key, this.onLogin,}) : super(key: key);

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> with Validator {
  final ValueNotifier<bool> emailSubmitNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordSubmitNotifier = ValueNotifier(false);
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();


  @override
  void dispose() {
    emailSubmitNotifier.dispose();
    passwordSubmitNotifier.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(28, 0, 28,28),
      child: Column(
        children: [
          buildTop(context),
          const SizedBox(
            height: 32,
          ),
          ValueListenableBuilder<bool>(
              valueListenable: emailSubmitNotifier,
              builder: (_, submit, __) {
                return AppInput.email(
                  borderColor: AppColors.grey,
                  formKey: _emailFormKey,
                  autovalidateMode: submit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  validator: emailValidatorHandler,
                  onChanged: (text) {
                    if (submit) {
                      emailSubmitNotifier.value = false;
                    }
                  },
                );
              }),
          const SizedBox(
            height: 4,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: passwordSubmitNotifier,
            builder: (_, submit, __) {
              return AppInput.password(
                borderColor: AppColors.grey,
                autovalidateMode: submit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                formKey: _passwordFormKey,
                validator: passwordValidatorHandler,
                onChanged: (text) {
                  if (submit) {
                    passwordSubmitNotifier.value = false;
                  }
                },
              );
            },
          ),
          const SizedBox(height: 12,),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: Text(
              S.of(context).forgotPassword,
              style: AppTextStyle.normal.copyWith(
                fontSize: 16,
                color: AppColors.orange,
              ),
            ),
          ),
          const SizedBox(height: 42,),
          AppButton(
            buttonColor: AppColors.lightYellow,
            buttonText: S.of(context).singIn.toUpperCase(),
            style: AppTextStyle.bold.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
            onPressed: onLogin,
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget buildTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).singIn,
          style: AppTextStyle.medium.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: null,
          icon: Image.asset(AppImages.icRemove),
          iconSize: 28,
        ),
      ],
    );
  }

  void onLogin() {
    submitNotifier();
    final emailValidate = _emailFormKey.currentState?.validate();
    final passwordValidate = _passwordFormKey.currentState?.validate();
    if (emailValidate! && passwordValidate!) {
      widget.onLogin!();
    }
  }

  void submitNotifier() {
    emailSubmitNotifier.value = true;
    passwordSubmitNotifier.value = true;
  }

  String? emailValidatorHandler(String? email) {
    // can return emailValidator(email);
    return emailValidator(
      email,
      validatorBuilder: (state) {
        switch (state) {
          case EmailValidationState.nonEmail:
            return S.of(context).nonEmail;
          case EmailValidationState.badEmail:
            return S.of(context).badEmail;
          default:
            return null;
        }
      },
    );
  }

  String? passwordValidatorHandler(String? text) {
    return passwordValidator(text);
  }
}
