import 'package:flutter/material.dart';

class AppTheme{

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
      )
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
      )
    ),
    dividerColor: Colors.white,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white), 
      fillColor: MaterialStateProperty.all(Colors.white),
      overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
      side: const BorderSide(color: Colors.white),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      tileColor: Colors.white, 
    ),
  );
}