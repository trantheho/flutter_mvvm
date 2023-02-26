import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/widgets/queue_snack_bar.dart';

enum DisplayPosition {
  bottom,
  top,
}

class ToastManager {
  const ToastManager();


  void showToast({
    required BuildContext context,
    String message = '',
    TextStyle? textStyle,
    DisplayPosition position = DisplayPosition.bottom,
    Widget? body,
  }) {
    switch (position) {
      case DisplayPosition.bottom:
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 1500),
            content: body ??
                Text(
                  message,
                  style: textStyle ?? const TextStyle(fontSize: 16, color: Colors.white),
                ),
          ),
        );
        break;
      case DisplayPosition.top:
        final snackBar = QueueSnackBar();
        snackBar.showSnackBar(
          Overlay.of(context),
          child: body ??
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.teal,
                ),
                child: Center(
                  child: Text(
                    message,
                    style: textStyle ?? const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
        );
        break;
    }
  }

  void showCustomBottomToast({required BuildContext context, required SnackBar snackBar,}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(snackBar);
  }
}
