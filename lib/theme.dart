import 'package:flutter/material.dart';


class AppTheme {
  
  ThemeData main = ThemeData(
    fontFamily: 'Jost',
    brightness: Brightness.dark,
    useMaterial3: true,
    splashColor: Colors.black,
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black,
        border: InputBorder.none
      )
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.red,
      textTheme: ButtonTextTheme.primary     
    ),
  );
}