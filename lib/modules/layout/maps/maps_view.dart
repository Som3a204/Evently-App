import 'package:flutter/material.dart';

import '../../../core/theme/color_pallette.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text("Maps", style: theme.textTheme.headlineLarge?.copyWith(color: ColorPallette.primaryColor)),
    );
  }
}
