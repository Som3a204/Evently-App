import 'package:evently_app/models/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:evently_app/core/theme/color_pallette.dart';

import '../../../core/constants/assets.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.onBoardingData});
  final OnBoardingData onBoardingData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(child: Image.asset(onBoardingData.imgPath)),
        SizedBox(height: 24,),
        Text(onBoardingData.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall!.copyWith( color: ColorPallette.primaryColor),),
        SizedBox(height: 24,),
        if(onBoardingData.description != null)
          Text(onBoardingData.description!,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge!.copyWith(color: ColorPallette.primaryColor),)
      ],
    );
  }
}

