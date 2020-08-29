import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/app/router.gr.dart';
import 'package:digitalcontractsapp/services/api.dart';
import 'package:digitalcontractsapp/utils/token.dart';
import 'package:stacked_services/stacked_services.dart';

class Initialize {
  BuildContext context;
  final Token token = new Token();

  setPage(String home) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    runApp(
      OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFF2f3640),
            accentColor: Color(0xFF353b48),
            fontFamily: 'Poppins',
            textTheme: TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(),
            ).apply(
              bodyColor: Color(0xFF232832),
              displayColor: Color(0xFF232832),
            ),
          ).copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              },
            ),
          ),
          onGenerateRoute: Router().onGenerateRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
          initialRoute: home,
        ),
      ),
    );
  }

  Initialize() {
    token.hasToken().then(
      (tokenResponse) async {
        setPage(Routes.onBoardingViewRoute);
      },
    );
  }
}
