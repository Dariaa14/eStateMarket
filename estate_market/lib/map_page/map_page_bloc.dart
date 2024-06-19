import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/position_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:domain/use_cases/location_use_case.dart';
import 'package:domain/use_cases/map_use_case.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:equatable/equatable.dart';

part 'map_page_event.dart';
part 'map_page_state.dart';

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
    on<InitPropertiesEvent>(_initPropertiesEventHandler);

    on<SelectedLandmarkUpdateEvent>(_selectedLandmarkUpdateEventHandler);
    on<SelectedAdUpdateEvent>(_selectedAdUpdateEventHandler);

    on<DeactivateLandmarkHightlightEvent>(_deactivateLandmarkHightlightEventHandler);
    on<CenterOnLandmarkEvent>(_centerOnLandmarkEventHandler);

    on<PositionUpdatedEvent>(_positionUpdatedEventHandler);
    on<PermissionStatusUpdatedEvent>(_permissionStatusUpdatedEventHandler);
    on<LocationStatusUpdatedEvent>(_locationStatusUpdatedEventHandler);
    on<InitializeLocationEvent>(_initializeLocationEventHandler);

    on<HighlightLandmarkEvent>(_highlightLandmarkEventHandler);

    on<ShowRouteRangeEvent>(_showRouteRangeEventHandler);

    on<SetTransportModeEvent>(_setTransportModeEventHandler);
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
    add(HighlightLandmarkEvent(landmark: event.landmark));
  }

  _initPropertiesEventHandler(InitPropertiesEvent event, Emitter<MapPageState> emit) {
    _mapUseCase = sl.get<MapUseCase>();
    add(InitializeLocationEvent());
    _mapUseCase!.highlightAllProperties();

    _mapUseCase!.registerMapGestureCallbacks((landmark) async {
      final AdEntity? ad = await _mapUseCase!.getAdOfLandmark(landmark);
      if (ad != null) {
        add(SelectedAdUpdateEvent(ad: ad));
      }
    });
  }

  _selectedAdUpdateEventHandler(SelectedAdUpdateEvent event, Emitter<MapPageState> emit) {
    if (event.ad == null) {
      emit(state.copyWithNullAd());
      return;
    }
    emit(state.copyWith(ad: event.ad));
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
    add(HighlightLandmarkEvent(landmark: event.landmark!));
  }

  _highlightLandmarkEventHandler(HighlightLandmarkEvent event, Emitter<MapPageState> emit) {
    _mapUseCase!.activateHighlight(event.landmark);
  }

  _deactivateLandmarkHightlightEventHandler(DeactivateLandmarkHightlightEvent event, Emitter<MapPageState> emit) {
    _mapUseCase!.deactivateAllHighlights();
    emit(state.copyWithNullLandmark());
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

  _showRouteRangeEventHandler(ShowRouteRangeEvent event, Emitter<MapPageState> emit) async {
    final isSuccesful = await _mapUseCase!.calculateRoute(event.landmark, state.transportMode);
    if (!isSuccesful) {
      emit(state.copyWith(wasRouteCalculated: !state.wasRouteCalculated));
    }
  }

  _setTransportModeEventHandler(SetTransportModeEvent event, Emitter<MapPageState> emit) {
    emit(state.copyWith(transportMode: event.mode));
  }

  @override
  Future<void> close() async {
    await _permissionStreamSubscription.cancel();
    await _positionStreamSubscription.cancel();
    await _locationStatusStreamSubscription.cancel();
    return super.close();
  }
}
