import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:equatable/equatable.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

//TODO: modify landmark logic
class MapPageBloc extends Bloc<MapPageEvent, MapPageState> {
  late MapUseCase? _mapUseCase;
  LandmarkEntity? _landmark;

  MapPageBloc() : super(const MapPageState()) {
    on<RequestLocationPermissionEvent>(_requestLocationPermissionEventHandler);
    on<FollowPositionEvent>(_followPositionEventHandler);

    on<InitAddressSelectionEvent>(_initAddressSelectionEventHandler);
    on<InitViewLandmarkEvent>(_initViewLandmarkEventHandler);
  }

  _initAddressSelectionEventHandler(InitAddressSelectionEvent event, Emitter<MapPageState> emit) {
    _mapUseCase = sl.get<MapUseCase>();

    _mapUseCase!.registerMapGestureCallbacks((landmark) {
      _landmark = landmark;
      //emit(state.copyWith(landmark: landmark));
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

  getCurrentLandmark() {
    return _landmark;
  }
}
