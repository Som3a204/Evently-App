import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/authentication/pages/forget_password_view.dart';
import 'package:evently_app/modules/authentication/pages/login_view.dart';
import 'package:evently_app/modules/authentication/pages/register_view.dart';
import 'package:evently_app/modules/event_creation/event_creation_view.dart';
import 'package:evently_app/modules/event_creation/pick_event_location_view.dart';
import 'package:evently_app/modules/event_details/edit_event_view.dart';
import 'package:evently_app/modules/event_details/event_details_view.dart';
import 'package:evently_app/modules/layout/layout_view.dart';
import 'package:evently_app/modules/onboarding/onboarding_view.dart';
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
    case PageRouteName.eventCreation:
      return MaterialPageRoute(
          builder: (BuildContext _) => EventCreationView(),
          settings: settings
      );
      case PageRouteName.pickEventLocation:
      return MaterialPageRoute(
          builder: (BuildContext _) => PickEventLocationView(),
          settings: settings
      );
      case PageRouteName.eventDetails:
        final eventData = settings.arguments as EventData;
      return MaterialPageRoute(
          builder: (BuildContext _) => EventDetailsView(eventData: eventData),
          settings: settings
      );
      case PageRouteName.editEvent:
        final eventData = settings.arguments as EventData;
      return MaterialPageRoute(
          builder: (BuildContext _) => EditEventView(eventData: eventData),
          settings: settings
      );
    case PageRouteName.onBoarding:
      return MaterialPageRoute(
          builder: (BuildContext _) => OnBoardingView(),
          settings: settings
      );
    default:
      return MaterialPageRoute(
  builder: (BuildContext _) => SplashView(),
      settings: settings);

  }
}
}