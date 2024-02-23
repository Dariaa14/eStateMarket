import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/document_reference_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:equatable/equatable.dart';

part 'create_ad_event.dart';
part 'create_ad_state.dart';

class CreateAdBloc extends Bloc<CreateAdEvent, CreateAdState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();

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
  }

  _insertInDatabaseEventHandler(InsertInDatabaseEvent event, Emitter<CreateAdState> emit) async {
    // TODO: verify if all fields are filled
    late DocumentReferenceEntity propertyReference;
    switch (state.currentCategory) {
      case AdCategory.garage:
        {
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
        listingType: state.listingType);
  }

  _changeIsNegotiableEventHandler(ChangeIsNegotiableEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(isNegotiable: event.isNegotiable));
  }

  _changeCurrentCategoryEventHandler(ChangeCurrentCategoryEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(currentCategory: event.category));
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
      emit(state.copyWithParkingCapacityNull());
      return;
    }
    emit(state.copyWith(parkingCapacity: int.parse(event.parkingCapacity)));
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
    emit(state.copyWith(numberOfRooms: int.parse(event.numberOfRooms)));
    print(state.numberOfRooms);
  }

  _changeNumberOfBathroomsEventHandler(ChangeNumberOfBathroomsEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(numberOfBathrooms: int.parse(event.numberOfBathooms)));

  _changeFloorEventHandler(ChangeFloorEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(floor: int.parse(event.floor)));

  _changeNumberOfFloorsEventHandler(ChangeNumberOfFloorsEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(numberOfFloors: int.parse(event.numberOfFloors)));

  _changeInsideSurfaceEventHandler(ChangeInsideSurfaceEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(insideSurface: double.parse(event.insideSurface)));

  _changeOutsideSurfaceEventHandler(ChangeOutsideSurfaceEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(outsideSurface: double.parse(event.outsideSurface)));

  _changeHeightEventHandler(ChangeHeightEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(height: double.parse(event.height)));

  _changeUsableSurfaceEventHandler(ChangeUsableSurfaceEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(usableSurface: double.parse(event.usableSurface)));

  _changeAdministrativeSurfaceEventHandler(ChangeAdministrativeSurfaceEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(administrativeSurface: double.parse(event.administrativeSurface)));

  _changeParkingSpacesEventHandler(ChangeParkingSpacesEvent event, Emitter<CreateAdState> emit) =>
      emit(state.copyWith(parkingSpaces: int.parse(event.parkingSpaces)));
}
