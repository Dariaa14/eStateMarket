import 'package:estate_market/create_ad_page/create_ad_view.dart';
import 'package:estate_market/main_page/main_page_view.dart';
import 'package:estate_market/register_page/register_page_view.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const String mainPage = '/';
  static const String registerPage = '/register';
  static const String createAdPage = '/createAdPage';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.mainPage:
      return routeBuilder(MainPageView());
    case RouteNames.registerPage:
      return routeBuilder(RegisterPage());
    case RouteNames.createAdPage:
      return routeBuilder(CreateAdView());
  }
  return null;
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

MaterialPageRoute routeBuilder(Widget page) {
  return MaterialPageRoute(builder: (context) => page);
}
