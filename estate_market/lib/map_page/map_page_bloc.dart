import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:equatable/equatable.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

class MapPageBloc extends Bloc<MapPageEvent, MapPageState> {
  late MapUseCase? _mapUseCase;

  MapPageBloc() : super(const MapPageState()) {
    on<RequestLocationPermissionEvent>(_requestLocationPermissionEventHandler);
    on<FollowPositionEvent>(_followPositionEventHandler);

    on<InitAddressSelectionEvent>(_initAddressSelectionEventHandler);
    on<InitViewLandmarkEvent>(_initViewLandmarkEventHandler);

    on<SelectedLandmarkUpdateEvent>(_selectedLandmarkUpdateEventHandler);
  }

  _initAddressSelectionEventHandler(InitAddressSelectionEvent event, Emitter<MapPageState> emit) {
    _mapUseCase = sl.get<MapUseCase>();

    _mapUseCase!.registerMapGestureCallbacks((landmark) {
      add(SelectedLandmarkUpdateEvent(landmark: landmark));
    });
  }

  _initViewLandmarkEventHandler(InitViewLandmarkEvent event, Emitter<MapPageState> emit) {
    _mapUseCase = sl.get<MapUseCase>();

    _mapUseCase!.centerOnCoordinates(event.landmark.getCoordinates());
  }

  _followPositionEventHandler(FollowPositionEvent event, Emitter<MapPageState> emit) {
    _mapUseCase!.startFollowingPosition();
  }

  _requestLocationPermissionEventHandler(RequestLocationPermissionEvent event, Emitter<MapPageState> emit) async {
    final status = await _mapUseCase!.requestLocationPermission();
    emit(state.copyWith(status: status));
  }

  _selectedLandmarkUpdateEventHandler(SelectedLandmarkUpdateEvent event, Emitter<MapPageState> emit) {
    if (event.landmark == null) {
      emit(state.copyWithNullLandmark());
      return;
    }
    emit(state.copyWith(landmark: event.landmark));
  }
}
