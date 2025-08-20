import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Widget? child;
  const CustomButtonWidget({super.key, this.onTap, this.backgroundColor,required this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorPallette.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide( color: ColorPallette.primaryColor)
          )
        ),
        child: child
    );
  }
}
