import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: 'Ubuntu'),
        bodyText1: TextStyle(
            fontSize: 18.0, color: Colors.white, fontFamily: 'Ubuntu'),
        bodyText2: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu'),
        headline4: TextStyle(
            fontSize: 10.0, color: Colors.black, fontFamily: 'Ubuntu'),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.blue[800],
      )));
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: 'Ubuntu'),
        bodyText1: TextStyle(
            fontSize: 18.0, color: Colors.white, fontFamily: 'Ubuntu'),
        bodyText2: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Ubuntu'),
        headline4: TextStyle(
            fontSize: 10.0, color: Colors.black, fontFamily: 'Ubuntu'),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.blue[800],
      )));
}

class Themeprovider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.light;
  void toggleTheme(bool ison) {
    themeMode = ison ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
