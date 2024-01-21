part of 'create_ad_bloc.dart';

class CreateAdState extends Equatable {
  final bool isNegotiable;

  final AdCategory currentCategory;
  final ListingType listingType;

  final LandUseCategories landUseCategory;
  final bool isInBuildUpArea;

  final ParkingType parkingType;
  final int? parkingCapacity;

  final FurnishingLevel furnishingLevel;

  final Partitioning partitioning;

  final DepositType depositType;

  const CreateAdState({
    this.isNegotiable = true,
    this.currentCategory = AdCategory.apartament,
    this.listingType = ListingType.sale,
    this.landUseCategory = LandUseCategories.urban,
    this.isInBuildUpArea = true,
    this.parkingType = ParkingType.interiorParking,
    this.parkingCapacity,
    this.furnishingLevel = FurnishingLevel.furnished,
    this.partitioning = Partitioning.selfContained,
    this.depositType = DepositType.deposit,
  });

  CreateAdState copyWith({
    bool? isNegotiable,
    AdCategory? currentCategory,
    ListingType? listingType,
    LandUseCategories? landUseCategory,
    bool? isInBuildUpArea,
    ParkingType? parkingType,
    int? parkingCapacity,
    FurnishingLevel? furnishingLevel,
    Partitioning? partitioning,
    DepositType? depositType,
  }) =>
      CreateAdState(
        isNegotiable: isNegotiable ?? this.isNegotiable,
        currentCategory: currentCategory ?? this.currentCategory,
        listingType: listingType ?? this.listingType,
        landUseCategory: landUseCategory ?? this.landUseCategory,
        isInBuildUpArea: isInBuildUpArea ?? this.isInBuildUpArea,
        parkingType: parkingType ?? this.parkingType,
        parkingCapacity: parkingCapacity ?? this.parkingCapacity,
        furnishingLevel: furnishingLevel ?? this.furnishingLevel,
        partitioning: partitioning ?? this.partitioning,
        depositType: depositType ?? this.depositType,
      );

  CreateAdState copyWithParkingCapacityNull() => CreateAdState(
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        landUseCategory: landUseCategory,
        isInBuildUpArea: isInBuildUpArea,
        parkingCapacity: null,
        parkingType: parkingType,
        furnishingLevel: furnishingLevel,
        partitioning: partitioning,
        depositType: depositType,
      );

  @override
  List<Object?> get props => [
        isNegotiable,
        currentCategory,
        listingType,
        landUseCategory,
        isInBuildUpArea,
        parkingType,
        parkingCapacity,
        furnishingLevel,
        partitioning,
        depositType,
      ];
}
