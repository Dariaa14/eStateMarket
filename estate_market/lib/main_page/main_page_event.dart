part of 'main_page_bloc.dart';

abstract class MainPageEvent {}

class InitMainPageEvent extends MainPageEvent {}

class FavoritesButtonPressedEvent extends MainPageEvent {
  final AdEntity ad;

  FavoritesButtonPressedEvent({required this.ad});
}

class SetAdsEvent extends MainPageEvent {
  final List<AdEntity> ads;

  SetAdsEvent({required this.ads});
}

class CurrentUserChangedEvent extends MainPageEvent {
  final bool isLoggedIn;

  CurrentUserChangedEvent({required this.isLoggedIn});
}

class DeleteAdEvent extends MainPageEvent {
  final AdEntity ad;

  DeleteAdEvent({required this.ad});
}

class ChangeCurrentCategoryEvent extends MainPageEvent {
  final AdCategory? category;

  ChangeCurrentCategoryEvent({required this.category});
}

class ChangeCurrentListingTypeEvent extends MainPageEvent {
  final ListingType? listingType;

  ChangeCurrentListingTypeEvent({required this.listingType});
}

class ChangePriceRangeEvent extends MainPageEvent {
  final Tuple2<double?, double?> priceRange;

  ChangePriceRangeEvent({required this.priceRange});
}

class ChangeSurfaceRangeEvent extends MainPageEvent {
  final Tuple2<double?, double?> surfaceRange;

  ChangeSurfaceRangeEvent({required this.surfaceRange});
}
