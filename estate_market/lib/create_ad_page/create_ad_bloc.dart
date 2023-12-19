import 'package:bloc/bloc.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:equatable/equatable.dart';

part 'create_ad_event.dart';
part 'create_ad_state.dart';

class CreateAdBloc extends Bloc<CreateAdEvent, CreateAdState> {
  CreateAdBloc() : super(const CreateAdState()) {
    on<ChangeCurrentCategoryEvent>(_changeCurrentCategoryEventHandler);
    on<ChangeListingTypeEvent>(_changeListingTypeEventHandler);

    on<ChangeLandUseCategoryEvent>(_changeLandUseCategoryEventHandler);
    on<ChangeBuildUpStatusEvent>(_changeBuildUpStatusEventHandler);

    on<ChangeParkingTypeCategoryEvent>(_changeParkingTypeCategoryEventHandler);

    on<ChangeFurnishingLevelCategoryEvent>(_changeFurnishingLevelCategoryEventHandler);
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

  _changeParkingTypeCategoryEventHandler(ChangeParkingTypeCategoryEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(parkingType: event.parkingType));
  }

  _changeFurnishingLevelCategoryEventHandler(ChangeFurnishingLevelCategoryEvent event, Emitter<CreateAdState> emit) {
    emit(state.copyWith(furnishingLevel: event.furnishingLevel));
  }
}
