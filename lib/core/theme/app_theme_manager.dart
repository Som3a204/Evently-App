import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

abstract class AppThemeManager{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: ColorPallette.primaryColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: "Inter",
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ColorPallette.generalTextColor
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
          backgroundColor: ColorPallette.primaryColor,
      selectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: Colors.white
      ),
        unselectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    textTheme: TextTheme(
        headlineSmall: TextStyle(
            fontSize: 24,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
        titleLarge: TextStyle(
            fontSize: 20,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
        titleMedium: TextStyle(
            fontSize: 18,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
        titleSmall: TextStyle(
            fontSize: 16,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
      bodyLarge: TextStyle(
          fontSize: 14,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),
      bodyMedium: TextStyle(
          fontSize: 12,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),
    )
  );
  static ThemeData darkTheme = ThemeData(
      primaryColor: ColorPallette.primaryColor
  );
}