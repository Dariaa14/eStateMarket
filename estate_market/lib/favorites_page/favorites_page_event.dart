part of 'favorites_page_bloc.dart';

abstract class FavoritesPageEvent {}

class InitFavoritesPageEvent extends FavoritesPageEvent {}

class SetFavoritesEvent extends FavoritesPageEvent {
  final List<AdEntity> ads;

  SetFavoritesEvent({required this.ads});
}
