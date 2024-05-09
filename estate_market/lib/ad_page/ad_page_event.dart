part of 'ad_page_bloc.dart';

abstract class AdPageEvent {}

class FavoritesButtonPressedEvent extends AdPageEvent {
  final AdEntity ad;

  FavoritesButtonPressedEvent({required this.ad});
}
