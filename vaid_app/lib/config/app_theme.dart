import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black, fontSize: 16),
      bodyText2: TextStyle(color: Colors.black54, fontSize: 14),
      headline6: TextStyle(color: Colors.black, fontSize: 20),
    ),
    // Add more custom theming here
  );
}
