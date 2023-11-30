import 'package:estate_market/main_page/main_page_view.dart';
import 'package:estate_market/register_page/register_page_view.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const String mainPage = '/';
  static const String registerPage = '/register';

  static Map<String, Widget Function(BuildContext)> routeMap = {
    mainPage: (context) => const MainPageView(),
    registerPage: (context) => RegisterPage(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.mainPage:
        return MaterialPageRoute(
          builder: (context) => const MainPageView(),
        );
      case RouteNames.registerPage:
        return MaterialPageRoute(
          builder: (context) => RegisterPage(),
        );
      default:
        return null;
    }
  }
}
