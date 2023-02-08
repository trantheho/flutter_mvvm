import 'package:flutter/material.dart';

import '../presentation/widgets/dialog.dart';
import 'manager/loading_manager.dart';
import 'router/app_router.dart';
import 'utils/app_helper.dart';

class AppController {
  final LoadingManager _loading;
  final AppRouter _router;
  final DialogController _dialog;
  final Toast _toast;
  final AppHelper _helper;

  AppController()
      :
        _router = AppRouter(),
        _dialog = DialogController(),
        _loading = LoadingManager(),
        _toast = Toast(),
        _helper = AppHelper();

  DialogController get dialog => _dialog;

  Toast get toast => _toast;

  LoadingManager get loading => _loading;

  AppHelper get helper => _helper;

  AppRouter get router => _router;

  bool alertTimeout = false;

  void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();
}

class Toast {
  void showToast({required BuildContext context, String message = '', TextStyle? textStyle}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          message,
          style: textStyle ?? const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void showCustomToast({required BuildContext context, required SnackBar snackBar}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(snackBar);
  }
}

final appController = AppController();
