import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_assets.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';

class DialogController {
  /// network dialog
  void showNetworkDialog({required BuildContext context, String? title, String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppAlertDialog(title: title, message: message),
    );
  }

  /// normal dialog
  void showDefaultDialog({required BuildContext context, String? title, String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AppAlertDialog(title: title, message: message),
    );
  }

  void showCreatedAccountDialog(
      {required BuildContext context, required String fullName, String? message, Function()? onSignIn}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CreatedAccountDialog(
        fullName: fullName,
        onSignIn: onSignIn,
      ),
    );
  }

  /// confirm dialog
  void showConfirmDialog(
      {required BuildContext context, String? title, String? message, Function? onOK}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmAlertDialog(
        title: title,
        message: message,
        onOkPress: () => onOK!(),
      ),
    );
  }
}

class AppAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;

  const AppAlertDialog({Key? key, this.title = "Alert", this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? 'Alert'),
      content: Text(message ?? 'Message'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}

class ConfirmAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Function? onOkPress;

  const ConfirmAlertDialog({
    Key? key,
    this.title = "Alert",
    this.message,
    this.onOkPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: Text(message ?? ''),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            onOkPress!();
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class CreatedAccountDialog extends StatefulWidget {
  final String fullName;
  final Function()? onSignIn;

  const CreatedAccountDialog({
    Key? key,
    required this.fullName,
    this.onSignIn,
  }) : super(key: key);

  @override
  State<CreatedAccountDialog> createState() => _CreatedAccountDialogState();
}

class _CreatedAccountDialogState extends State<CreatedAccountDialog> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 450,
      ),
      reverseDuration: const Duration(
        milliseconds: 300,
      ),
    )..forward();
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ScaleTransition(
            scale: animation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(21),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.congratulations),
                          fit: BoxFit.contain,
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 45,
                          ),
                          Text(
                            'Congratulations!',
                            style: AppTextStyle.bold.copyWith(
                              fontSize: 28,
                              color: AppColors.orange,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            widget.fullName,
                            style: AppTextStyle.bold.copyWith(
                              color: AppColors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 45,
                        right: 45,
                      ),
                      child: AppButton(
                        buttonColor: AppColors.lightYellow,
                        buttonText: S.of(context).singIn.toUpperCase(),
                        style: AppTextStyle.medium.copyWith(fontSize: 13),
                        onPressed: () async {
                          await animationController.reverse();
                          handlePop();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handlePop(){
    Navigator.pop(context);
    if (widget.onSignIn != null) {
      widget.onSignIn!();
    }
  }
}
