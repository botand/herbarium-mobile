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
            theme.progressIndicatorTheme.copyWith(color: Colors.white),
        bottomSheetTheme: theme.bottomSheetTheme.copyWith(
            modalBackgroundColor: purple,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(color: leafGreen))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: leafGreen, onPrimary: Colors.black)),
        sliderTheme: theme.sliderTheme.copyWith(
            valueIndicatorColor: Colors.blueGrey,
            activeTrackColor: leafGreen,
            inactiveTrackColor: Colors.grey,
            thumbColor: leafGreen,
            overlayColor: leafGreen.withAlpha(128),
            valueIndicatorShape: theme.sliderTheme.valueIndicatorShape),
        dialogTheme: theme.dialogTheme.copyWith(backgroundColor: purple));
  }
}
