import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static final ThemeData appTheme = ThemeData(
      primaryColor: const Color.fromRGBO(3, 140, 62, 1),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(3, 140, 62, 1),
        onPrimary: const Color.fromRGBO(255, 255, 255, 1),
        secondary: const Color.fromRGBO(199, 228, 211, 1),
        background: const Color.fromRGBO(241, 241, 241, 1),
        tertiary: const Color.fromRGBO(88, 122, 166, 1),
        onSecondary: const Color.fromRGBO(0, 0, 0, 1),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(fontFamily: 'Inter'),
        titleLarge: TextStyle(fontFamily: 'Inter'),
        titleSmall: TextStyle(fontFamily: 'Inter'),
      ),
      fontFamily: 'Roboto');
}
