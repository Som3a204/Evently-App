import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/modules/authentication/pages/forget_password_view.dart';
import 'package:evently_app/modules/authentication/pages/login_view.dart';
import 'package:evently_app/modules/authentication/pages/register_view.dart';
import 'package:evently_app/modules/layout/layout_view.dart';
import 'package:evently_app/modules/splash/pages/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes{
static Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch (settings.name){
    case PageRouteName.initial:
      return MaterialPageRoute(
          builder: (BuildContext _) => SplashView(),
      settings: settings
      );
    case PageRouteName.login:
      return MaterialPageRoute(
          builder: (BuildContext _) => LoginView(),
          settings: settings
      );
    case PageRouteName.layout:
      return MaterialPageRoute(
          builder: (BuildContext _) => LayoutView(),
          settings: settings
      );
    case PageRouteName.register:
      return MaterialPageRoute(
          builder: (BuildContext _) => RegisterView(),
          settings: settings
      );
    case PageRouteName.forgetPassword:
      return MaterialPageRoute(
          builder: (BuildContext _) => ForgetPasswordView(),
          settings: settings
      );
    default:
      return MaterialPageRoute(
  builder: (BuildContext _) => SplashView(),
      settings: settings);

  }
}
}