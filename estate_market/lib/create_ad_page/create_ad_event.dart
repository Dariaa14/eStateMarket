part of 'create_ad_bloc.dart';

abstract class CreateAdEvent {}

class InitAdEvent extends CreateAdEvent {
  final AdEntity? ad;

  InitAdEvent({this.ad});
}

class InsertInDatabaseEvent extends CreateAdEvent {
  final String title;
  final String description;

  final String surface;
  final String price;
  final String constructionYear;

  InsertInDatabaseEvent(
      {required this.title,
      required this.description,
      required this.surface,
      required this.price,
      required this.constructionYear});
}

class UpdateDatabaseEvent extends CreateAdEvent {
  final String title;
  final String description;

  final String surface;
  final String price;
  final String constructionYear;

  final AdEntity ad;

  UpdateDatabaseEvent({
    required this.title,
    required this.description,
    required this.surface,
    required this.price,
    required this.constructionYear,
    required this.ad,
  });
}

class ChangeIsNegotiableEvent extends CreateAdEvent {
  final bool? isNegotiable;

  ChangeIsNegotiableEvent({required this.isNegotiable});
}

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

class ChangeParkingTypeEvent extends CreateAdEvent {
  final ParkingType? parkingType;

  ChangeParkingTypeEvent({required this.parkingType});
}

class ChangeParkingCapacityEvent extends CreateAdEvent {
  final String parkingCapacity;
  ChangeParkingCapacityEvent({required this.parkingCapacity});
}

class ChangeFurnishingLevelCategoryEvent extends CreateAdEvent {
  final FurnishingLevel? furnishingLevel;

  ChangeFurnishingLevelCategoryEvent({required this.furnishingLevel});
}

class ChangePartitioningEvent extends CreateAdEvent {
  final Partitioning? partitioning;

  ChangePartitioningEvent({required this.partitioning});
}

class ChangeDepositTypeEvent extends CreateAdEvent {
  final DepositType? depositType;

  ChangeDepositTypeEvent({required this.depositType});
}

class ChangeNumberOfRoomsEvent extends CreateAdEvent {
  final String numberOfRooms;

  ChangeNumberOfRoomsEvent({required this.numberOfRooms});
}

class ChangeNumberOfBathroomsEvent extends CreateAdEvent {
  final String numberOfBathrooms;

  ChangeNumberOfBathroomsEvent({required this.numberOfBathrooms});
}

class ChangeFloorEvent extends CreateAdEvent {
  final String floor;

  ChangeFloorEvent({required this.floor});
}

class ChangeInsideSurfaceEvent extends CreateAdEvent {
  final String insideSurface;

  ChangeInsideSurfaceEvent({required this.insideSurface});
}

class ChangeOutsideSurfaceEvent extends CreateAdEvent {
  final String outsideSurface;

  ChangeOutsideSurfaceEvent({required this.outsideSurface});
}

class ChangeNumberOfFloorsEvent extends CreateAdEvent {
  final String numberOfFloors;

  ChangeNumberOfFloorsEvent({required this.numberOfFloors});
}

class ChangeHeightEvent extends CreateAdEvent {
  final String height;

  ChangeHeightEvent({required this.height});
}

class ChangeUsableSurfaceEvent extends CreateAdEvent {
  final String usableSurface;

  ChangeUsableSurfaceEvent({required this.usableSurface});
}

class ChangeAdministrativeSurfaceEvent extends CreateAdEvent {
  final String administrativeSurface;

  ChangeAdministrativeSurfaceEvent({required this.administrativeSurface});
}

class ChangeParkingSpacesEvent extends CreateAdEvent {
  final String parkingSpaces;

  ChangeParkingSpacesEvent({required this.parkingSpaces});
}

class SetEmptyFieldsEvent extends CreateAdEvent {
  final CreateAdFields field;
  final bool shouldRemove;

  SetEmptyFieldsEvent({required this.field, required this.shouldRemove});
}

class SetImagesEvent extends CreateAdEvent {
  final List<CustomImage> images;

  SetImagesEvent({required this.images});
}

class AddImagesEvent extends CreateAdEvent {
  final List<CustomImage> images;

  AddImagesEvent({required this.images});
}

class SetLandmarkEvent extends CreateAdEvent {
  final LandmarkEntity? landmark;

  SetLandmarkEvent({required this.landmark});
}
