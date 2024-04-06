part of 'main_page_bloc.dart';

abstract class MainPageEvent {}

class InitMainPageEvent extends MainPageEvent {}

class FavoritesButtonPressedEvent extends MainPageEvent {
  final AdEntity ad;

  FavoritesButtonPressedEvent({required this.ad});
}
