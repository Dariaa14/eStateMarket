part of 'create_ad_bloc.dart';

abstract class CreateAdEvent {}

class ChangeCurrentCategoryEvent extends CreateAdEvent {
  final AdCategory? category;

  ChangeCurrentCategoryEvent({required this.category});
}

class ChangeListingTypeEvent extends CreateAdEvent {
  final ListingType? listingType;

  ChangeListingTypeEvent({required this.listingType});
}

class ChangeLandUseCategoryEvent extends CreateAdEvent {
  final LandUseCategories? landUseCategory;

  ChangeLandUseCategoryEvent({required this.landUseCategory});
}

class ChangeBuildUpStatusEvent extends CreateAdEvent {
  final bool? buildUpStatus;

  ChangeBuildUpStatusEvent({required this.buildUpStatus});
}

class ChangeParkingTypeCategoryEvent extends CreateAdEvent {
  final ParkingType? parkingType;

  ChangeParkingTypeCategoryEvent({required this.parkingType});
}

class ChangeFurnishingLevelCategoryEvent extends CreateAdEvent {
  final FurnishingLevel? furnishingLevel;

  ChangeFurnishingLevelCategoryEvent({required this.furnishingLevel});
}
