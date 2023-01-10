import 'package:flutter/material.dart';

class LoadingManager{
  final ValueNotifier<bool> loadingManager = ValueNotifier(false);

  void show() => loadingManager.value = true;
  void hide() => loadingManager.value = false;
  void dispose() => loadingManager.dispose();
}