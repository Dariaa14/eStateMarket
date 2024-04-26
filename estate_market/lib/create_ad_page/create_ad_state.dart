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

enum CreateAdStatus { normal, loading, finished }

class CreateAdState extends Equatable {
  final List<CreateAdFields> emptyFields;
  final bool showErrors;
  final CreateAdStatus status;
  final List<File> images;
  final LandmarkEntity? landmark;

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
      this.showErrors = false,
      this.status = CreateAdStatus.normal,
      this.images = const [],
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
      this.parkingSpaces,
      this.landmark});

  CreateAdState copyWith(
          {List<CreateAdFields>? emptyFields,
          bool? showErrors,
          CreateAdStatus? status,
          List<File>? images,
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
          int? parkingSpaces,
          LandmarkEntity? landmark}) =>
      CreateAdState(
        emptyFields: emptyFields ?? this.emptyFields,
        showErrors: showErrors ?? this.showErrors,
        status: status ?? this.status,
        images: images ?? this.images,
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
        landmark: landmark ?? this.landmark,
      );

  CreateAdState copyGarage({int? parkingCapacity}) => CreateAdState(
        emptyFields: emptyFields,
        showErrors: showErrors,
        images: images,
        status: status,
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        parkingCapacity: parkingCapacity,
        parkingType: parkingType,
        landmark: landmark,
      );

  CreateAdState copyResidence({
    int? numberOfBathrooms,
    int? numberOfRooms,
  }) =>
      CreateAdState(
        emptyFields: emptyFields,
        showErrors: showErrors,
        images: images,
        status: status,
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
        landmark: landmark,
      );

  CreateAdState copyApartment({
    int? floor,
  }) =>
      CreateAdState(
        emptyFields: emptyFields,
        showErrors: showErrors,
        images: images,
        status: status,
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        partitioning: partitioning,
        furnishingLevel: furnishingLevel,
        floor: floor,
        numberOfBathrooms: numberOfBathrooms,
        numberOfRooms: numberOfRooms,
        landmark: landmark,
      );

  CreateAdState copyHouse({
    int? numberOfFloors,
    double? insideSurface,
    double? outsideSurface,
  }) =>
      CreateAdState(
        emptyFields: emptyFields,
        showErrors: showErrors,
        images: images,
        status: status,
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        furnishingLevel: furnishingLevel,
        numberOfBathrooms: numberOfBathrooms,
        numberOfRooms: numberOfRooms,
        numberOfFloors: numberOfFloors,
        insideSurface: insideSurface,
        outsideSurface: outsideSurface,
        landmark: landmark,
      );

  CreateAdState copyDeposit({
    int? parkingSpaces,
    double? height,
    double? usableSurface,
    double? administrativeSurface,
  }) =>
      CreateAdState(
        emptyFields: emptyFields,
        showErrors: showErrors,
        images: images,
        status: status,
        isNegotiable: isNegotiable,
        currentCategory: currentCategory,
        listingType: listingType,
        height: height,
        usableSurface: usableSurface,
        administrativeSurface: administrativeSurface,
        depositType: depositType,
        parkingSpaces: parkingSpaces,
        landmark: landmark,
      );

  @override
  List<Object?> get props => [
        showErrors,
        emptyFields,
        images,
        status,
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
        landmark,
      ];
}
