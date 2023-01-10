import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
import 'package:flutter_mvvm/presentation/widgets/input.dart';

class RegisterLayout extends StatefulWidget {
  final Function(String)? onFirstNameChange;
  final Function(String)? onLastNameChange;
  final Function(String)? onRegisterEmailChange;
  final Function(String)? onRegisterPasswordChange;
  final Function()? onClear;
  final Function()? onCreateAnAccount;

  const RegisterLayout({
    Key? key,
    this.onFirstNameChange,
    this.onLastNameChange,
    this.onRegisterEmailChange,
    this.onRegisterPasswordChange,
    this.onClear,
    this.onCreateAnAccount,
  }) : super(key: key);

  @override
  State<RegisterLayout> createState() => _RegisterLayoutState();
}

class _RegisterLayoutState extends State<RegisterLayout> with Validator {
  final ValueNotifier<bool> emailSubmitNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordSubmitNotifier = ValueNotifier(false);
  final ValueNotifier<bool> firstNameSubmitNotifier = ValueNotifier(false);
  final ValueNotifier<bool> lastNameSubmitNotifier = ValueNotifier(false);
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _firstNameFormKey = GlobalKey<FormState>();
  final _lastNameFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailSubmitNotifier.dispose();
    passwordSubmitNotifier.dispose();
    firstNameSubmitNotifier.dispose();
    lastNameSubmitNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
      child: Column(
        children: [
          buildTop(context),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: firstNameSubmitNotifier,
                  builder: (_, submit, __) {
                    return AppInput.text(
                      hintText: 'First name',
                      formKey: _firstNameFormKey,
                      borderColor: AppColors.orange,
                      onChanged:(text){
                        if(submit){
                          firstNameSubmitNotifier.value = false;
                        }
                        widget.onFirstNameChange!(text);
                      },
                      autovalidateMode: submit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                      validator: firstNameValidatorHandler,
                    );
                  }
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: lastNameSubmitNotifier,
                  builder: (_, submit, __) {
                    return AppInput.text(
                      hintText: 'Last name',
                      formKey: _lastNameFormKey,
                      borderColor: AppColors.orange,
                      onChanged: (text){
                        if(submit){
                          lastNameSubmitNotifier.value = false;
                        }
                        widget.onLastNameChange!(text);
                      },
                      autovalidateMode: submit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                      validator: lastNameValidatorHandler,
                    );
                  }
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          ValueListenableBuilder<bool>(
              valueListenable: emailSubmitNotifier,
              builder: (_, submit, __) {
                return AppInput.email(
                  borderColor: AppColors.orange,
                  formKey: _emailFormKey,
                  autovalidateMode: submit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                  validator: emailValidatorHandler,
                  onChanged: (text) {
                    if (submit) {
                      emailSubmitNotifier.value = false;
                    }
                    widget.onRegisterEmailChange!(text);
                  },
                );
              },),
          const SizedBox(
            height: 4,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: passwordSubmitNotifier,
            builder: (_, submit, __) {
              return AppInput.password(
                borderColor: AppColors.orange,
                autovalidateMode: submit ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                formKey: _passwordFormKey,
                validator: passwordValidatorHandler,
                onChanged: (text) {
                  if (submit) {
                    passwordSubmitNotifier.value = false;
                  }
                  widget.onRegisterPasswordChange!(text);
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _buildTermCondition(),
          const SizedBox(
            height: 42,
          ),
          AppButton(
            buttonColor: AppColors.lightYellow,
            buttonText: S.of(context).createAnAccount.toUpperCase(),
            style: AppTextStyle.bold.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
            onPressed: onCreateAnAccount,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget buildTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).createYourAccount,
          style: AppTextStyle.medium.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: widget.onClear,
          icon: Image.asset(AppImages.icRemove),
          iconSize: 28,
        ),
      ],
    );
  }

  Widget _buildTermCondition() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "By tapping Sign up you accept all",
              style: AppTextStyle.normal.copyWith(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: "\nterms",
              style: AppTextStyle.bold.copyWith(
                fontSize: 14,
                color: AppColors.lightYellow,
              ),
            ),
            TextSpan(
              text: " and ",
              style: AppTextStyle.normal.copyWith(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: "condition",
              style: AppTextStyle.bold.copyWith(
                fontSize: 14,
                color: AppColors.lightYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreateAnAccount() {
    submitNotifier();
    final emailValidate = _emailFormKey.currentState?.validate();
    final passwordValidate = _passwordFormKey.currentState?.validate();
    final firstNameValidate = _firstNameFormKey.currentState?.validate();
    final lastNameValidate = _lastNameFormKey.currentState?.validate();
    if (emailValidate! && passwordValidate! && firstNameValidate! && lastNameValidate!) {
      widget.onCreateAnAccount!();
    }
  }

  void submitNotifier() {
    emailSubmitNotifier.value = true;
    passwordSubmitNotifier.value = true;
    firstNameSubmitNotifier.value = true;
    lastNameSubmitNotifier.value = true;
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

  String? firstNameValidatorHandler(String? text){
    return firstNameValidator(text, validatorBuilder: (state){
      switch(state){
        case NameValidationState.emptyName:
          return "First name is empty";
        case NameValidationState.valid:
        default:
          return null;
      }
    },);
  }

  String? lastNameValidatorHandler(String? text){
    return lastNameValidator(text, validatorBuilder: (state){
      switch(state){
        case NameValidationState.emptyName:
          return "Last name is empty";
        case NameValidationState.valid:
        default:
          return null;
      }
    },);
  }
}
