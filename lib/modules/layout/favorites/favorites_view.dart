import 'package:flutter/material.dart';

import '../../../core/theme/color_pallette.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text("Favorites View", style: theme.textTheme.headlineLarge?.copyWith(color: ColorPallette.primaryColor)),
    );
  }
}
