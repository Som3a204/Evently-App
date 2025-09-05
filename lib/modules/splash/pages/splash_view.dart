import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Image.asset(Assets.eventAppLogo, height: 185),
      ),
    );
  }
}
