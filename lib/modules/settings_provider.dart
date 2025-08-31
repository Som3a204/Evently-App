import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'en';

  void changeLanguage(String newLanguage){
    if(newLanguage == currentLanguage){
      return;
    }
    currentLanguage = newLanguage;
    notifyListeners();
  }
  void changeTheme (ThemeMode newTheme){
    if(currentTheme == newTheme){
      return;
    }
    currentTheme = newTheme;
    notifyListeners();
  }
  bool isDark() => currentTheme == ThemeMode.dark;
}