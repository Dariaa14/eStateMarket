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
  }

  _insertInDatabaseEventHandler(InsertInDatabaseEvent event, Emitter<CreateAdState> emit) async {
    late DocumentReferenceEntity propertyReference;
    switch (state.currentCategory) {
      case AdCategory.garage:
        {
          propertyReference = await _databaseUseCase.insertGarageEntity(
              double.parse(event.surface),
              double.parse(event.price),
              state.isNegotiable,
              (event.constructionYear.isEmpty) ? null : int.parse(event.constructionYear),
              state.parkingType,
              state.parkingCapacity!);
        }
      default:
        break;
    }
    await _databaseUseCase.insertAdEntity(
        event.title, state.currentCategory, event.description, propertyReference, state.listingType);
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
}
