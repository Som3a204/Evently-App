import 'package:flutter/material.dart';

import '../../../core/theme/color_pallette.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text("Profile View", style: theme.textTheme.headlineLarge?.copyWith(color: ColorPallette.primaryColor)),
    );;
  }
}
