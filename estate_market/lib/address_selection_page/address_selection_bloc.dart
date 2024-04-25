import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:equatable/equatable.dart';

part 'address_selection_event.dart';
part 'address_selection_state.dart';

class AddressSelectionBloc extends Bloc<AddressSelectionEvent, AddressSelectionState> {
  late MapUseCase? _mapUseCase;

  AddressSelectionBloc() : super(const AddressSelectionState()) {
    on<RequestLocationPermissionEvent>(_requestLocationPermissionEventHandler);
    on<FollowPositionEvent>(_followPositionEventHandler);
    on<InitAddressSelectionEvent>(_initAddressSelectionEventHandler);
  }

  _initAddressSelectionEventHandler(InitAddressSelectionEvent event, Emitter<AddressSelectionState> emit) {
    _mapUseCase = sl.get<MapUseCase>();

    _mapUseCase!.registerMapGestureCallbacks((landmark) {
      //TODO: finish this:
      // emit(state.copyWith(landmark: landmark));
    });
  }

  _followPositionEventHandler(FollowPositionEvent event, Emitter<AddressSelectionState> emit) {
    _mapUseCase!.startFollowingPosition();
  }

  _requestLocationPermissionEventHandler(
      RequestLocationPermissionEvent event, Emitter<AddressSelectionState> emit) async {
    final status = await _mapUseCase!.requestLocationPermission();
    emit(state.copyWith(status: status));
  }
}
