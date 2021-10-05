import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const purple = Color(0xff40356f);
  static const leafGreen = Color(0xff88bd5e);
  static const gray = Color(0xff747474);

  static ThemeData theme() {
    final ThemeData theme = ThemeData.dark();

    return theme.copyWith(
        primaryColor: purple,
        scaffoldBackgroundColor: purple,
        appBarTheme:
            theme.appBarTheme.copyWith(backgroundColor: purple, elevation: 0));
  }
}
