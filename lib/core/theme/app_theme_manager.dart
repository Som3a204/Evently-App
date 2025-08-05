import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

abstract class AppThemeManager{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: ColorPallette.primaryColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20,
          fontFamily: "Inter",
        fontWeight: FontWeight.w500,
        color: Colors.white
      ),
        bodyMedium: TextStyle(
            fontSize: 16,
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            color: Colors.white
        )
    )
  );
  static ThemeData darkTheme = ThemeData(
      primaryColor: ColorPallette.primaryColor
  );
}