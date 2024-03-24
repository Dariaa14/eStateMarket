import 'package:estate_market/create_ad_page/create_ad_view.dart';
import 'package:estate_market/main_page/main_page_view.dart';
import 'package:estate_market/profile_page/subpages/edit_profile_page/edit_profile_page_view.dart';
import 'package:estate_market/register_page/register_page_view.dart';
import 'package:flutter/material.dart';

import '../profile_page/profile_page_view.dart';

class RouteNames {
  static const String mainPage = '/';
  static const String registerPage = '/register';
  static const String createAdPage = '/createAdPage';
  static const String profilePage = '/profile';
  static const String editProfilePage = '/profile/editProfile';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.mainPage:
      return routeBuilder(MainPageView());
    case RouteNames.registerPage:
      return routeBuilder(RegisterPage());
    case RouteNames.createAdPage:
      return routeBuilder(CreateAdView());
    case RouteNames.profilePage:
      return routeBuilder(ProfilePageView());
    case RouteNames.editProfilePage:
      return routeBuilder(EditProfilePageView());
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
