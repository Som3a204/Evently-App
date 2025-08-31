import 'package:flutter/material.dart';
import 'package:evently_app/core/theme/color_pallette.dart';

class DotIndicator extends StatelessWidget {
  DotIndicator({super.key,required this.isActive});
  bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(milliseconds: 200),
        height: 7,
        width: isActive ? 24 : 7,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: isActive ? ColorPallette.primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(20)
        ));
  }
}