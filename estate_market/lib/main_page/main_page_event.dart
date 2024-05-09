part of 'main_page_bloc.dart';

abstract class MainPageEvent {}

class InitMainPageEvent extends MainPageEvent {}

class FavoritesButtonPressedEvent extends MainPageEvent {
  final AdEntity ad;

  FavoritesButtonPressedEvent({required this.ad});
}

class CurrentUserChangedEvent extends MainPageEvent {
  final bool isLoggedIn;

  CurrentUserChangedEvent({required this.isLoggedIn});
}
