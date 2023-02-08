import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

DateTime? clickTime;

class AppHelper {

  /// set status bar style overlay ui
  SystemUiOverlayStyle statusBarOverlayUI(Brightness? androidBrightness) {
    late SystemUiOverlayStyle statusBarStyle;
    if (Platform.isIOS) {
      statusBarStyle = (androidBrightness == Brightness.light)
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark;
    }
    if (Platform.isAndroid) {
      statusBarStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: androidBrightness ?? Brightness.light);
    }
    return statusBarStyle;
  }

  void distinctClick({required Function action}) {
    DateTime now = DateTime.now();
    if (clickTime == null) {
      clickTime = now;
      action();
    }
    if (now.difference(clickTime!).inSeconds < 1) return;
    clickTime = now;
    action();
  }

  void showBottomSheet(context, Widget child,
      [isScrollControlled = false]) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: isScrollControlled,
        builder: (context) {
          return isScrollControlled
              ? DraggableScrollableSheet(
                  initialChildSize: 0.6, // half screen on load
                  maxChildSize: 1, // full screen on scroll
                  minChildSize: 0.25,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return child;
                  },
                )
              : child;
        });
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
