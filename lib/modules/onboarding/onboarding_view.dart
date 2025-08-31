import 'package:flutter/material.dart';
import 'package:evently_app/core/constants/strings.dart';
import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/models/onboarding_data.dart';
import 'package:evently_app/modules/onBoarding/widgets/dot_indicator.dart';
import 'package:evently_app/modules/onBoarding/widgets/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/assets.dart';

class OnBoardingView extends StatefulWidget {
  OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      currentIndex = pageController.page?.toInt() ?? 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ColorPallette.generalBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.onBoardingHeader, height: size.height * 0.10),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemBuilder:
                  (context, index) => OnBoardingPage(
                onBoardingData: OnBoardingData.onBoardingList[index],
              ),
              itemCount: OnBoardingData.onBoardingList.length,
            ),
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed:
                    currentIndex != 0
                        ? () {
                      pageController.animateToPage(
                        currentIndex - 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                        : null,
                    style: TextButton.styleFrom(
                      foregroundColor: ColorPallette.primaryColor,
                      backgroundColor: Colors.transparent,
                    ),
                    icon: currentIndex != 0 ? Icon(Icons.arrow_back,color: ColorPallette.primaryColor,) : SizedBox.shrink(),
                  ),
                  IconButton(
                    onPressed: () {
                      if(currentIndex ==2){
                        _seenOnBoarding();
                      }
                      else{
                        pageController.animateToPage(
                            currentIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: ColorPallette.primaryColor,
                      backgroundColor: Colors.transparent,
                    ),
                    icon: Icon(Icons.arrow_forward,color: ColorPallette.primaryColor,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  OnBoardingData.onBoardingList.length,
                      (index) => DotIndicator(isActive: index == currentIndex),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void _seenOnBoarding() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('firstTime', false);
    Navigator.pushNamed(context, PageRouteName.login);
  }
}


