part of 'create_ad_bloc.dart';

class CreateAdState extends Equatable {
  final AdCategory currentCategory;
  final ListingType listingType;

  final LandUseCategories landUseCategory;
  final bool isInBuildUpArea;

  final ParkingType parkingType;

  final FurnishingLevel furnishingLevel;

  const CreateAdState({
    this.currentCategory = AdCategory.apartament,
    this.listingType = ListingType.sale,
    this.landUseCategory = LandUseCategories.urban,
    this.isInBuildUpArea = true,
    this.parkingType = ParkingType.interiorParking,
    this.furnishingLevel = FurnishingLevel.furnished,
  });

  CreateAdState copyWith({
    AdCategory? currentCategory,
    ListingType? listingType,
    LandUseCategories? landUseCategory,
    bool? isInBuildUpArea,
    ParkingType? parkingType,
    FurnishingLevel? furnishingLevel,
  }) =>
      CreateAdState(
        currentCategory: currentCategory ?? this.currentCategory,
        listingType: listingType ?? this.listingType,
        landUseCategory: landUseCategory ?? this.landUseCategory,
        isInBuildUpArea: isInBuildUpArea ?? this.isInBuildUpArea,
        parkingType: parkingType ?? this.parkingType,
        furnishingLevel: furnishingLevel ?? this.furnishingLevel,
      );

  @override
  List<Object> get props => [
        currentCategory,
        listingType,
        landUseCategory,
        isInBuildUpArea,
        parkingType,
        furnishingLevel,
      ];
}
