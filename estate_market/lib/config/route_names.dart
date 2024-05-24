import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:estate_market/ad_page/ad_page_view.dart';
import 'package:estate_market/create_ad_page/create_ad_view.dart';
import 'package:estate_market/filters_page/filters_page_view.dart';
import 'package:estate_market/main_page/main_page_view.dart';
import 'package:estate_market/map_page/map_page_view.dart';
import 'package:estate_market/profile_page/subpages/my_ads_page/my_ads_view_page.dart';
import 'package:estate_market/profile_page/subpages/edit_profile_page/edit_profile_page_view.dart';
import 'package:estate_market/register_page/register_page_view.dart';
import 'package:flutter/material.dart';

import '../favorites_page/favorites_view_page.dart';
import '../profile_page/profile_page_view.dart';

class RouteNames {
  static const String mainPage = '/';
  static const String registerPage = '/register';

  static const String createAdPage = '/createAdPage';
  static const String mapPage = '/mapPage';

  static const String profilePage = '/profile';
  static const String editProfilePage = '/profile/editProfile';
  static const String myAdsPage = '/profile/myAds';

  static const String favoritesPage = '/favorites';

  static const String adPage = '/adPage';

  static const String filtersPage = '/filters';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.mainPage:
      return routeBuilder(const MainPageView());
    case RouteNames.registerPage:
      return routeBuilder(RegisterPage());
    case RouteNames.createAdPage:
      return routeBuilder(CreateAdView(ad: settings.arguments as AdEntity?));
    case RouteNames.profilePage:
      return routeBuilder(const ProfilePageView());
    case RouteNames.editProfilePage:
      return routeBuilder(EditProfilePageView());
    case RouteNames.adPage:
      final ad = (settings.arguments as Map<String, dynamic>)['ad'] as AdEntity;
      final canUserModifyAdd = (settings.arguments as Map<String, dynamic>)['canUserModifyAdd'] as bool?;
      return routeBuilder(AdPageView(
        ad: ad,
        canUserModifyAdd: canUserModifyAdd ?? false,
      ));
    case RouteNames.mapPage:
      return routeBuilder(MapPageView(landmark: settings.arguments as LandmarkEntity?));
    case RouteNames.favoritesPage:
      return routeBuilder(const FavoritesViewPage());
    case RouteNames.myAdsPage:
      return routeBuilder(const MyAdsViewPage());
    case RouteNames.filtersPage:
      return routeBuilder(FiltersPageView());
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
