import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    primaryColor: AppColors.orange,
    backgroundColor: Colors.white,
    primaryColorLight: Colors.black,
    textTheme: TextTheme(
      displaySmall: AppTextStyle.normal.copyWith(
        color: Colors.black,
      ),
      displayMedium: AppTextStyle.medium.copyWith(
        color: Colors.black,
      ),
      displayLarge: AppTextStyle.bold.copyWith(
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    bottomAppBarColor: Colors.white,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.grey177,
    ),
  );

  static final dark = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: Colors.black54,
    primaryColorLight: Colors.orange,
    textTheme: TextTheme(
      displaySmall: AppTextStyle.normal.copyWith(
        color: Colors.white,
      ),
      displayMedium: AppTextStyle.medium.copyWith(
        color: Colors.white,
      ),
      displayLarge: AppTextStyle.bold.copyWith(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    bottomAppBarColor: Colors.black54,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
    ),
  );
}
