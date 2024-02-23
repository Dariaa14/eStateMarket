part of 'create_ad_bloc.dart';

enum CreateAdFields {
  title,
  description,
  surface,
  price,
  numberOfRooms,
  numberOfBathrooms,
  floorNumber,
  insideSurface,
  outsideSurface,
  numberOfFloors,
  garageCapacity,
  height,
  usableSurface,
  administrativeSurface,
  parkingSpaces,
}

class CreateAdState extends Equatable {
  final List<CreateAdFields> emptyFields;

  final bool isNegotiable;
  final AdCategory currentCategory;
  final ListingType listingType;

  final LandUseCategories landUseCategory;
  final bool isInBuildUpArea;

  final ParkingType parkingType;
  final int? parkingCapacity;

  final int? numberOfRooms;
  final int? numberOfBathrooms;

  final int? floor;
  final FurnishingLevel furnishingLevel;
  final Partitioning partitioning;

  final double? insideSurface;
  final double? outsideSurface;
  final int? numberOfFloors;

  final DepositType depositType;
  final double? height;
  final double? usableSurface;
  final double? administrativeSurface;
  final int? parkingSpaces;

  const CreateAdState(
      {this.emptyFields = CreateAdFields.values,
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
      this.numberOfRooms,
      this.numberOfBathrooms,
      this.floor,
      this.insideSurface,
      this.outsideSurface,
      this.numberOfFloors,
      this.height,
      this.usableSurface,
      this.administrativeSurface,
      this.parkingSpaces});

  CreateAdState copyWith(
          {List<CreateAdFields>? emptyFields,
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
          int? numberOfRooms,
          int? numberOfBathrooms,
          int? floor,
          double? insideSurface,
          double? outsideSurface,
          int? numberOfFloors,
          double? height,
          double? usableSurface,
          double? administrativeSurface,
          int? parkingSpaces}) =>
      CreateAdState(
        emptyFields: emptyFields ?? this.emptyFields,
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
        numberOfBathrooms: numberOfBathrooms ?? this.numberOfBathrooms,
        numberOfRooms: numberOfRooms ?? this.numberOfRooms,
        floor: floor ?? this.floor,
        insideSurface: insideSurface ?? this.insideSurface,
        outsideSurface: outsideSurface ?? this.outsideSurface,
        numberOfFloors: numberOfFloors ?? this.numberOfFloors,
        height: height ?? this.height,
        usableSurface: usableSurface ?? this.usableSurface,
        administrativeSurface: administrativeSurface ?? this.administrativeSurface,
        parkingSpaces: parkingSpaces ?? this.parkingSpaces,
      );

  CreateAdState copyGarage({int? parkingCapacity}) => CreateAdState(
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        parkingCapacity: parkingCapacity,
        parkingType: parkingType,
      );

  CreateAdState copyResidence({
    int? numberOfBathrooms,
    int? numberOfRooms,
  }) =>
      CreateAdState(
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        partitioning: partitioning,
        furnishingLevel: furnishingLevel,
        floor: floor,
        numberOfBathrooms: numberOfBathrooms,
        numberOfRooms: numberOfRooms,
        numberOfFloors: numberOfFloors,
        insideSurface: insideSurface,
        outsideSurface: outsideSurface,
      );

  CreateAdState copyApartment({
    int? floor,
  }) =>
      CreateAdState(
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        partitioning: partitioning,
        furnishingLevel: furnishingLevel,
        floor: floor,
        numberOfBathrooms: numberOfBathrooms,
        numberOfRooms: numberOfRooms,
      );

  CreateAdState copyHouse({
    int? numberOfFloors,
    double? insideSurface,
    double? outsideSurface,
  }) =>
      CreateAdState(
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        furnishingLevel: furnishingLevel,
        numberOfBathrooms: numberOfBathrooms,
        numberOfRooms: numberOfRooms,
        numberOfFloors: numberOfFloors,
        insideSurface: insideSurface,
        outsideSurface: outsideSurface,
      );

  CreateAdState copyDeposit({
    int? parkingSpaces,
    double? height,
    double? usableSurface,
    double? administrativeSurface,
  }) =>
      CreateAdState(
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        height: height,
        usableSurface: usableSurface,
        administrativeSurface: administrativeSurface,
        depositType: depositType,
        parkingSpaces: parkingSpaces,
      );

  @override
  List<Object?> get props => [
        emptyFields,
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
        numberOfRooms,
        numberOfBathrooms,
        floor,
        insideSurface,
        outsideSurface,
        numberOfFloors,
        height,
        usableSurface,
        administrativeSurface,
        parkingSpaces,
      ];
}
