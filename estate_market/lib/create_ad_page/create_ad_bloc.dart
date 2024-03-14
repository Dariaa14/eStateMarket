import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:equatable/equatable.dart';

part 'create_ad_event.dart';
part 'create_ad_state.dart';

class CreateAdBloc extends Bloc<CreateAdEvent, CreateAdState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();
  final List<CreateAdFields> specificAdFields = [
    CreateAdFields.numberOfRooms,
    CreateAdFields.numberOfBathrooms,
    CreateAdFields.floorNumber,
    CreateAdFields.insideSurface,
    CreateAdFields.outsideSurface,
    CreateAdFields.numberOfFloors,
    CreateAdFields.garageCapacity,
    CreateAdFields.height,
    CreateAdFields.usableSurface,
    CreateAdFields.administrativeSurface,
    CreateAdFields.parkingSpaces
  ];

  CreateAdBloc() : super(const CreateAdState()) {
    on<InsertInDatabaseEvent>(_insertInDatabaseEventHandler);

    on<ChangeIsNegotiableEvent>(_changeIsNegotiableEventHandler);

    on<ChangeCurrentCategoryEvent>(_changeCurrentCategoryEventHandler);
    on<ChangeListingTypeEvent>(_changeListingTypeEventHandler);

    on<ChangeLandUseCategoryEvent>(_changeLandUseCategoryEventHandler);
    on<ChangeBuildUpStatusEvent>(_changeBuildUpStatusEventHandler);

    on<ChangeParkingTypeEvent>(_changeParkingTypeCategoryEventHandler);
    on<ChangeParkingCapacityEvent>(_changeParkingCapacityEventHandler);

    on<ChangeFurnishingLevelCategoryEvent>(_changeFurnishingLevelCategoryEventHandler);

    on<ChangePartitioningEvent>(_changePartitioningEventHandler);

    on<ChangeDepositTypeEvent>(_changeDepositTypeEventHandler);

    on<ChangeNumberOfRoomsEvent>(_changeNumberOfRoomsEventHandler);
    on<ChangeNumberOfBathroomsEvent>(_changeNumberOfBathroomsEventHandler);
    on<ChangeFloorEvent>(_changeFloorEventHandler);

    on<ChangeInsideSurfaceEvent>(_changeInsideSurfaceEventHandler);
    on<ChangeOutsideSurfaceEvent>(_changeOutsideSurfaceEventHandler);
    on<ChangeNumberOfFloorsEvent>(_changeNumberOfFloorsEventHandler);

    on<ChangeHeightEvent>(_changeHeightEventHandler);
    on<ChangeUsableSurfaceEvent>(_changeUsableSurfaceEventHandler);
    on<ChangeAdministrativeSurfaceEvent>(_changeAdministrativeSurfaceEventHandler);
    on<ChangeParkingSpacesEvent>(_changeParkingSpacesEventHandler);

    on<SetEmptyFieldsEvent>(_setEmptyFieldsEventHandler);
    on<SetImagesEvent>(_setImagesEventHandler);
    on<AddImagesEvent>(_addImagesEventHandler);
  }

  _insertInDatabaseEventHandler(InsertInDatabaseEvent event, Emitter<CreateAdState> emit) async {
    if (state.emptyFields.contains(CreateAdFields.title) || state.emptyFields.contains(CreateAdFields.description)) {
      emit(state.copyWith(showErrors: true));
      return;
    }

    final imageUploadResult = await _databaseUseCase.uploadImages(state.images.map((image) => image.path).toList());
    if (imageUploadResult.isLeft()) {
      print("Error uploading images");
      return;
    }

    late DocumentReferenceEntity propertyReference;
    switch (state.currentCategory) {
      case AdCategory.garage:
        {
          if (state.emptyFields.contains(CreateAdFields.garageCapacity)) {
            emit(state.copyWith(showErrors: true));
            return;
          }
          propertyReference = await _databaseUseCase.insertGarageEntity(
              surface: double.parse(event.surface),
              price: double.parse(event.price),
              isNegotiable: state.isNegotiable,
              constructionYear: (event.constructionYear.isEmpty) ? null : int.parse(event.constructionYear),
              parkingType: state.parkingType,
              capacity: state.parkingCapacity!);
          break;
        }
      case AdCategory.terrain:
        {
          propertyReference = await _databaseUseCase.insertTerrainEntity(
            surface: double.parse(event.surface),
            price: double.parse(event.price),
            isNegotiable: state.isNegotiable,
            constructionYear: (event.constructionYear.isEmpty) ? null : int.parse(event.constructionYear),
            isInBuildUpArea: state.isInBuildUpArea,
            landUseCategory: state.landUseCategory,
          );
          break;
        }
      case AdCategory.apartament:
        {
          if (state.emptyFields.contains(CreateAdFields.floorNumber) ||
              state.emptyFields.contains(CreateAdFields.numberOfBathrooms) ||
              state.emptyFields.contains(CreateAdFields.numberOfRooms)) {
            emit(state.copyWith(showErrors: true));
            return;
          }
          propertyReference = await _databaseUseCase.insertApartmentEntity(
            surface: double.parse(event.surface),
            price: double.parse(event.price),
            isNegotiable: state.isNegotiable,
            constructionYear: (event.constructionYear.isEmpty) ? null : int.parse(event.constructionYear),
            partitioning: state.partitioning,
            furnishingLevel: state.furnishingLevel,
            floor: state.floor!,
            numberOfBathrooms: state.numberOfBathrooms!,
            numberOfRooms: state.numberOfRooms!,
          );
          break;
        }
      case AdCategory.house:
        {
          if (state.emptyFields.contains(CreateAdFields.numberOfFloors) ||
              state.emptyFields.contains(CreateAdFields.numberOfBathrooms) ||
              state.emptyFields.contains(CreateAdFields.numberOfRooms) ||
              state.emptyFields.contains(CreateAdFields.insideSurface) ||
              state.emptyFields.contains(CreateAdFields.outsideSurface)) {
            emit(state.copyWith(showErrors: true));
            return;
          }
          propertyReference = await _databaseUseCase.insertHouseEntity(
            surface: double.parse(event.surface),
            price: double.parse(event.price),
            isNegotiable: state.isNegotiable,
            constructionYear: (event.constructionYear.isEmpty) ? null : int.parse(event.constructionYear),
            furnishingLevel: state.furnishingLevel,
            numberOfBathrooms: state.numberOfBathrooms!,
            numberOfRooms: state.numberOfRooms!,
            insideSurface: state.insideSurface!,
            outsideSurface: state.outsideSurface!,
            numberOfFloors: state.numberOfFloors!,
          );
          break;
        }
      case AdCategory.deposit:
        {
          if (state.emptyFields.contains(CreateAdFields.usableSurface) ||
              state.emptyFields.contains(CreateAdFields.administrativeSurface) ||
              state.emptyFields.contains(CreateAdFields.parkingSpaces)) {
            emit(state.copyWith(showErrors: true));
            return;
          }
          propertyReference = await _databaseUseCase.insertDepositEntity(
            surface: double.parse(event.surface),
            price: double.parse(event.price),
            isNegotiable: state.isNegotiable,
            constructionYear: (event.constructionYear.isEmpty) ? null : int.parse(event.constructionYear),
            height: state.height!,
            usableSurface: state.usableSurface!,
            administrativeSurface: state.administrativeSurface!,
            depositType: state.depositType,
            parkingSpaces: state.parkingSpaces!,
          );
          break;
        }

      default:
        break;
    }
    await _databaseUseCase.insertAdEntity(
        title: event.title,
        category: state.currentCategory,
        description: event.description,
        property: propertyReference,
        listingType: state.listingType,
        images: (imageUploadResult as Right).value);
    emit(state.copyWith(insertSuccesful: true));
  }

  _changeIsNegotiableEventHandler(ChangeIsNegotiableEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(isNegotiable: event.isNegotiable));
  }

  _changeCurrentCategoryEventHandler(ChangeCurrentCategoryEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(currentCategory: event.category));
    for (CreateAdFields field in specificAdFields) {
      add(SetEmptyFieldsEvent(field: field, shouldRemove: false));
    }
  }

  _changeListingTypeEventHandler(ChangeListingTypeEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(listingType: event.listingType));
  }

  _changeLandUseCategoryEventHandler(ChangeLandUseCategoryEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(landUseCategory: event.landUseCategory));
  }

  _changeBuildUpStatusEventHandler(ChangeBuildUpStatusEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(isInBuildUpArea: event.buildUpStatus));
  }

  _changeParkingTypeCategoryEventHandler(ChangeParkingTypeEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(parkingType: event.parkingType));
  }

  _changeParkingCapacityEventHandler(ChangeParkingCapacityEvent event, Emitter<CreateAdState> emit) {
    if (event.parkingCapacity.isEmpty) {
      emit(state.copyGarage(parkingCapacity: null));
      add(SetEmptyFieldsEvent(field: CreateAdFields.garageCapacity, shouldRemove: false));
      return;
    }
    emit(state.copyWith(parkingCapacity: int.parse(event.parkingCapacity)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.garageCapacity, shouldRemove: true));
  }

  _changeFurnishingLevelCategoryEventHandler(ChangeFurnishingLevelCategoryEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(furnishingLevel: event.furnishingLevel));
  }

  _changePartitioningEventHandler(ChangePartitioningEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(partitioning: event.partitioning));
  }

  _changeDepositTypeEventHandler(ChangeDepositTypeEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(depositType: event.depositType));
  }

  _changeNumberOfRoomsEventHandler(ChangeNumberOfRoomsEvent event, Emitter<CreateAdState> emit) {
    if (event.numberOfRooms.isEmpty) {
      emit(state.copyResidence(numberOfBathrooms: state.numberOfBathrooms));
      add(SetEmptyFieldsEvent(field: CreateAdFields.numberOfRooms, shouldRemove: false));
      return;
    }
    emit(state.copyWith(numberOfRooms: int.parse(event.numberOfRooms)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.numberOfRooms, shouldRemove: true));
  }

  _changeNumberOfBathroomsEventHandler(ChangeNumberOfBathroomsEvent event, Emitter<CreateAdState> emit) {
    if (event.numberOfBathrooms.isEmpty) {
      emit(state.copyResidence(numberOfRooms: state.numberOfRooms));
      add(SetEmptyFieldsEvent(field: CreateAdFields.numberOfBathrooms, shouldRemove: false));
      return;
    }
    emit(state.copyWith(numberOfBathrooms: int.parse(event.numberOfBathrooms)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.numberOfBathrooms, shouldRemove: true));
  }

  _changeFloorEventHandler(ChangeFloorEvent event, Emitter<CreateAdState> emit) {
    if (event.floor.isEmpty) {
      emit(state.copyApartment());
      add(SetEmptyFieldsEvent(field: CreateAdFields.floorNumber, shouldRemove: false));
      return;
    }
    emit(state.copyWith(floor: int.parse(event.floor)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.floorNumber, shouldRemove: true));
  }

  _changeNumberOfFloorsEventHandler(ChangeNumberOfFloorsEvent event, Emitter<CreateAdState> emit) {
    if (event.numberOfFloors.isEmpty) {
      emit(state.copyHouse(insideSurface: state.insideSurface, outsideSurface: state.outsideSurface));
      add(SetEmptyFieldsEvent(field: CreateAdFields.numberOfFloors, shouldRemove: false));
      return;
    }
    emit(state.copyWith(numberOfFloors: int.parse(event.numberOfFloors)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.numberOfFloors, shouldRemove: true));
  }

  _changeInsideSurfaceEventHandler(ChangeInsideSurfaceEvent event, Emitter<CreateAdState> emit) {
    if (event.insideSurface.isEmpty) {
      emit(state.copyHouse(numberOfFloors: state.numberOfFloors, outsideSurface: state.outsideSurface));
      add(SetEmptyFieldsEvent(field: CreateAdFields.insideSurface, shouldRemove: false));
      return;
    }
    emit(state.copyWith(insideSurface: double.parse(event.insideSurface)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.insideSurface, shouldRemove: true));
  }

  _changeOutsideSurfaceEventHandler(ChangeOutsideSurfaceEvent event, Emitter<CreateAdState> emit) {
    if (event.outsideSurface.isEmpty) {
      emit(state.copyHouse(insideSurface: state.insideSurface, numberOfFloors: state.numberOfFloors));
      add(SetEmptyFieldsEvent(field: CreateAdFields.outsideSurface, shouldRemove: false));
      return;
    }
    emit(state.copyWith(outsideSurface: double.parse(event.outsideSurface)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.outsideSurface, shouldRemove: true));
  }

  _changeHeightEventHandler(ChangeHeightEvent event, Emitter<CreateAdState> emit) {
    if (event.height.isEmpty) {
      emit(state.copyDeposit(
          usableSurface: state.usableSurface,
          administrativeSurface: state.administrativeSurface,
          parkingSpaces: state.parkingSpaces));
      add(SetEmptyFieldsEvent(field: CreateAdFields.height, shouldRemove: false));
      return;
    }
    emit(state.copyWith(height: double.parse(event.height)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.height, shouldRemove: true));
  }

  _changeUsableSurfaceEventHandler(ChangeUsableSurfaceEvent event, Emitter<CreateAdState> emit) {
    if (event.usableSurface.isEmpty) {
      emit(state.copyDeposit(
          height: state.height,
          administrativeSurface: state.administrativeSurface,
          parkingSpaces: state.parkingSpaces));
      add(SetEmptyFieldsEvent(field: CreateAdFields.usableSurface, shouldRemove: false));
      return;
    }
    emit(state.copyWith(usableSurface: double.parse(event.usableSurface)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.usableSurface, shouldRemove: true));
  }

  _changeAdministrativeSurfaceEventHandler(ChangeAdministrativeSurfaceEvent event, Emitter<CreateAdState> emit) {
    if (event.administrativeSurface.isEmpty) {
      emit(state.copyDeposit(
          height: state.height, usableSurface: state.usableSurface, parkingSpaces: state.parkingSpaces));
      add(SetEmptyFieldsEvent(field: CreateAdFields.administrativeSurface, shouldRemove: false));
      return;
    }
    emit(state.copyWith(administrativeSurface: double.parse(event.administrativeSurface)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.administrativeSurface, shouldRemove: true));
  }

  _changeParkingSpacesEventHandler(ChangeParkingSpacesEvent event, Emitter<CreateAdState> emit) {
    if (event.parkingSpaces.isEmpty) {
      emit(state.copyDeposit(
          height: state.height,
          usableSurface: state.usableSurface,
          administrativeSurface: state.administrativeSurface));
      add(SetEmptyFieldsEvent(field: CreateAdFields.parkingSpaces, shouldRemove: false));
      return;
    }
    emit(state.copyWith(parkingSpaces: int.parse(event.parkingSpaces)));
    add(SetEmptyFieldsEvent(field: CreateAdFields.parkingSpaces, shouldRemove: true));
  }

  _setEmptyFieldsEventHandler(SetEmptyFieldsEvent event, Emitter<CreateAdState> emit) {
    List<CreateAdFields> newEmptyFields = List.from(state.emptyFields);
    if (newEmptyFields.contains(event.field) && event.shouldRemove == true) {
      newEmptyFields.remove(event.field);
    } else if (!newEmptyFields.contains(event.field) && event.shouldRemove == false) {
      newEmptyFields.add(event.field);
    }
    emit(state.copyWith(emptyFields: newEmptyFields));
  }

  bool fieldIsEmpty(CreateAdFields field) {
    return state.emptyFields.contains(field);
  }

  _setImagesEventHandler(SetImagesEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(images: event.images));

  _addImagesEventHandler(AddImagesEvent event, Emitter<CreateAdState> emit) {
    List<File> allImages = List.from(event.images);
    allImages.addAll(state.images);

    Set<String> uniquePaths = allImages.map((image) => image.path.substring(image.path.lastIndexOf('/') + 1)).toSet();
    List<File> uniqueImages =
        uniquePaths.map((uniquePath) => allImages.firstWhere((image) => image.path.endsWith(uniquePath))).toList();

    emit(state.copyWith(images: uniqueImages));
  }
}
