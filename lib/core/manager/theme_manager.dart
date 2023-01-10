import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeManager extends Notifier<ThemeData>{
  final ThemeData localTheme;

  ThemeManager(this.localTheme);


  final ThemeData light = ThemeData(

  );


  final dark = ThemeData(

  );

  ThemeData get currentTheme => state;

  @override
  ThemeData build() {
    return localTheme;
  }
}