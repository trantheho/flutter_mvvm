import 'package:flutter/material.dart';
import 'styles.dart';

ThemeData appLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base;
  /*return base.copyWith(
      dividerColor: AppColors.greyish,
      colorScheme: ColorScheme.light(
        primary: AppColors.verdigris,
        onPrimary: AppColors.white,
        secondary: AppColors.terraCotta,
        onSecondary: AppColors.white,
        background: AppColors.white,
        onBackground: AppColors.blackTwo,
        error: Colors.red,
        onError: AppColors.white,
      )
  );*/
}

ThemeData appDarkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base;
  /*return base.copyWith(
    backgroundColor: AppColors.nightRider,
    colorScheme: ColorScheme.dark(
      primary: AppColors.nightRider,
    ),
    scaffoldBackgroundColor: AppColors.nightRider,
  );*/
}