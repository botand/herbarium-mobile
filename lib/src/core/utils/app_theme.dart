import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const purpleLight = Color(0xff40356f);
  static const purple = Color(0xff1a152d);
  static const leafGreen = Color(0xff88bd5e);
  static const gray = Color(0xff747474);

  static ThemeData theme() {
    final ThemeData theme = ThemeData.dark();

    return theme.copyWith(
        scaffoldBackgroundColor: purple,
        colorScheme: theme.colorScheme
            .copyWith(primary: purple, secondary: Colors.white),
        appBarTheme:
            theme.appBarTheme.copyWith(backgroundColor: purple, elevation: 0),
        bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
            backgroundColor: purple,
            elevation: 10,
            selectedIconTheme: const IconThemeData(color: leafGreen)),
        progressIndicatorTheme:
            theme.progressIndicatorTheme.copyWith(color: Colors.white));
  }
}
