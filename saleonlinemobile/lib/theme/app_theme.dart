import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color.fromARGB(255, 250, 250, 250);
  static Color lightPrimaryColor = const Color.fromARGB(223, 7, 113, 219);
  static Color lightSecondaryColor = const Color(0xff040415);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticlesColor = const Color.fromRGBO(0, 0, 0, 0.451);
  static Color lightTextColor = Colors.black54;
  static Color lightPrimaryFixedColor = const Color.fromARGB(255, 255, 162, 22);

  const AppTheme._();

  static final lightTheme = ThemeData(
      bottomAppBarTheme: BottomAppBarTheme(color: lightPrimaryColor),
      brightness: Brightness.light,
      primaryColor: lightPrimaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(backgroundColor: lightPrimaryColor),
      colorScheme: ColorScheme.light(
          secondary: lightSecondaryColor,
          primary: lightParticlesColor,
          primaryFixed: lightPrimaryFixedColor),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: TextStyle(color: lightBackgroundColor))));

  static Brightness get currentSystemBrightness =>
      // ignore: deprecated_member_use
      SchedulerBinding.instance.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: lightBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent));
  }
}
