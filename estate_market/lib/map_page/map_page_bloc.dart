import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/wrappers/position_entity.dart';
import 'package:domain/use_cases/location_use_case.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:equatable/equatable.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

//TODO: continue from here
class MapPageBloc extends Bloc<MapPageEvent, MapPageState> {
  late MapUseCase? _mapUseCase;

  final LocationUseCase _locationUseCase = sl.get<LocationUseCase>();

  late StreamSubscription _permissionStreamSubscription;
  late StreamSubscription _positionStreamSubscription;
  late StreamSubscription _locationStatusStreamSubscription;

  MapPageBloc() : super(const MapPageState()) {
    on<RequestLocationPermissionEvent>(_requestLocationPermissionEventHandler);
    on<FollowPositionEvent>(_followPositionEventHandler);

    on<InitAddressSelectionEvent>(_initAddressSelectionEventHandler);
    on<InitViewLandmarkEvent>(_initViewLandmarkEventHandler);

    on<SelectedLandmarkUpdateEvent>(_selectedLandmarkUpdateEventHandler);

    on<CenterOnLandmarkEvent>(_centerOnLandmarkEventHandler);

    on<PositionUpdatedEvent>(_positionUpdatedEventHandler);
    on<PermissionStatusUpdatedEvent>(_permissionStatusUpdatedEventHandler);
    on<LocationStatusUpdatedEvent>(_locationStatusUpdatedEventHandler);
    on<InitializeLocationEvent>(_initializeLocationEventHandler);
  }

  _initAddressSelectionEventHandler(InitAddressSelectionEvent event, Emitter<MapPageState> emit) {
    _mapUseCase = sl.get<MapUseCase>();
    add(InitializeLocationEvent());

    _mapUseCase!.registerMapGestureCallbacks((landmark) {
      add(SelectedLandmarkUpdateEvent(landmark: landmark));
    });
  }

  _initViewLandmarkEventHandler(InitViewLandmarkEvent event, Emitter<MapPageState> emit) {
    _mapUseCase = sl.get<MapUseCase>();
    add(InitializeLocationEvent());
    add(CenterOnLandmarkEvent(landmark: event.landmark));
  }

  _centerOnLandmarkEventHandler(CenterOnLandmarkEvent event, Emitter<MapPageState> emit) {
    _mapUseCase!.centerOnCoordinates(event.landmark.getCoordinates());
  }

  _followPositionEventHandler(FollowPositionEvent event, Emitter<MapPageState> emit) {
    _mapUseCase!.startFollowingPosition();
  }

  _requestLocationPermissionEventHandler(RequestLocationPermissionEvent event, Emitter<MapPageState> emit) async {
    final hasPermission = await _locationUseCase.askLocationPermission();
    if (hasPermission != _locationUseCase.hasLocationPermission) {
      emit(state.copyWith(hasLocationPermission: hasPermission));
      await _locationUseCase.updatePermissionsStatus();
    }
  }

  _selectedLandmarkUpdateEventHandler(SelectedLandmarkUpdateEvent event, Emitter<MapPageState> emit) {
    if (event.landmark == null) {
      emit(state.copyWithNullLandmark());
      return;
    }
    emit(state.copyWith(landmark: event.landmark));
    _mapUseCase!.activateHighlight(event.landmark!);
  }

  _positionUpdatedEventHandler(PositionUpdatedEvent event, Emitter<MapPageState> emit) {
    if (event.position == null) {
      emit(state.copyWithNullPosition());
    } else {
      emit(state.copyWith(currentPosition: event.position));
    }
  }

  _permissionStatusUpdatedEventHandler(PermissionStatusUpdatedEvent event, Emitter<MapPageState> emit) =>
      emit(state.copyWith(hasLocationPermission: event.hasPermission));

  _locationStatusUpdatedEventHandler(LocationStatusUpdatedEvent event, Emitter<MapPageState> emit) =>
      emit(state.copyWith(isLocationEnabled: event.isEnabled));

  _initializeLocationEventHandler(InitializeLocationEvent event, Emitter<MapPageState> emit) {
    _locationUseCase.initialize();

    _positionStreamSubscription = _locationUseCase.positionStream.listen((position) {
      if (isClosed) return;
      add(PositionUpdatedEvent(position: position));
    });

    _permissionStreamSubscription = _locationUseCase.locationStatusStream.listen((isEnabled) {
      if (isClosed) return;
      add(LocationStatusUpdatedEvent(isEnabled: isEnabled));
    });

    _locationStatusStreamSubscription = _locationUseCase.locationPermissionStream.listen((isEnabled) {
      if (isClosed) return;
      add(PermissionStatusUpdatedEvent(hasPermission: isEnabled));
    });
  }

  @override
  Future<void> close() async {
    await _permissionStreamSubscription.cancel();
    await _positionStreamSubscription.cancel();
    await _locationStatusStreamSubscription.cancel();
    return super.close();
  }
}
