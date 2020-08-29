// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:digitalcontractsapp/ui/views/login/login_view.dart';
import 'package:digitalcontractsapp/ui/views/user_home/user_home_view.dart';
import 'package:digitalcontractsapp/ui/views/principal/principal_view.dart';
import 'package:digitalcontractsapp/ui/views/enroll/enroll_view.dart';
import 'package:digitalcontractsapp/ui/views/onboarding/onboarding_view.dart';
import 'package:digitalcontractsapp/ui/views/contracts_register/contracts_register_view.dart';

abstract class Routes {
  static const loginViewRoute = '/';
  static const homeViewRoute = '/home-view-route';
  static const principalViewRoute = '/principal-view-route';
  static const enrollViewRoute = '/enroll-view-route';
  static const onBoardingViewRoute = '/on-boarding-view-route';
  static const contractsRegisterViewRoute = '/contracts-register-view-route';
  static const all = {
    loginViewRoute,
    homeViewRoute,
    principalViewRoute,
    enrollViewRoute,
    onBoardingViewRoute,
    contractsRegisterViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.loginViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => UserHomeView(),
          settings: settings,
        );
      case Routes.principalViewRoute:
        if (hasInvalidArgs<PrincipalViewArguments>(args)) {
          return misTypedArgsRoute<PrincipalViewArguments>(args);
        }
        final typedArgs =
            args as PrincipalViewArguments ?? PrincipalViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              PrincipalView(currentIndex: typedArgs.currentIndex),
          settings: settings,
        );
      case Routes.enrollViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => EnrollView(),
          settings: settings,
        );
      case Routes.onBoardingViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => OnBoardingView(),
          settings: settings,
        );
      case Routes.contractsRegisterViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ContractsRegisterView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//PrincipalView arguments holder class
class PrincipalViewArguments {
  final int currentIndex;
  PrincipalViewArguments({this.currentIndex = 0});
}