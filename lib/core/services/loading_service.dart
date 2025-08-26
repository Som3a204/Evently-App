import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

void configLoading(){
  EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..radius = 10
      ..maskType = EasyLoadingMaskType.black
      ..backgroundColor = Colors.white
      ..textColor = Colors.white
      ..indicatorColor = ColorPallette.primaryColor
      ..userInteractions = false
      ..dismissOnTap = false;
}