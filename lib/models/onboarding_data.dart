import 'package:evently_app/core/constants/strings.dart';
import '../core/constants/assets.dart';

class OnBoardingData {
  String imgPath;
  String title;
  String? description;
  OnBoardingData({
    required this.imgPath,
    required this.title,
    this.description,
  });
  static List<OnBoardingData> onBoardingList = [
    OnBoardingData(imgPath: Assets.onBoarding1, title: Strings.onBoardingTitle1, description: Strings.onBoardingDescription1),
    OnBoardingData(
      imgPath: Assets.onBoarding2,
      title: Strings.onBoardingTitle2,
      description: Strings.onBoardingDescription2,
    ), OnBoardingData(
      imgPath: Assets.onBoarding3,
      title: Strings.onBoardingTitle3,
      description: Strings.onBoardingDescription3,
    ),

  ];
}
