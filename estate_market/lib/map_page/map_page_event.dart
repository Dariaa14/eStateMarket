part of 'map_page_bloc.dart';

abstract class MapPageEvent {}

class RequestLocationPermissionEvent extends MapPageEvent {}

class FollowPositionEvent extends MapPageEvent {}

class InitAddressSelectionEvent extends MapPageEvent {}

class InitPropertiesEvent extends MapPageEvent {}

class SelectedLandmarkUpdateEvent extends MapPageEvent {
  final LandmarkEntity? landmark;

  SelectedLandmarkUpdateEvent({required this.landmark});
}

class SelectedAdUpdateEvent extends MapPageEvent {
  final AdEntity? ad;

  SelectedAdUpdateEvent({required this.ad});
}

class CenterOnLandmarkEvent extends MapPageEvent {
  final LandmarkEntity landmark;

  CenterOnLandmarkEvent({required this.landmark});
}

class InitViewLandmarkEvent extends MapPageEvent {
  final LandmarkEntity landmark;

  InitViewLandmarkEvent({required this.landmark});
}

class PositionUpdatedEvent extends MapPageEvent {
  final PositionEntity? position;

  PositionUpdatedEvent({required this.position});
}

class PermissionStatusUpdatedEvent extends MapPageEvent {
  final bool hasPermission;

  PermissionStatusUpdatedEvent({required this.hasPermission});
}

class LocationStatusUpdatedEvent extends MapPageEvent {
  final bool isEnabled;

  LocationStatusUpdatedEvent({required this.isEnabled});
}

class HighlightLandmarkEvent extends MapPageEvent {
  final LandmarkEntity landmark;

  HighlightLandmarkEvent({required this.landmark});
}

class DeactivateLandmarkHightlightEvent extends MapPageEvent {}

class InitializeLocationEvent extends MapPageEvent {}

class ShowRouteRangeEvent extends MapPageEvent {
  final LandmarkEntity landmark;

  ShowRouteRangeEvent({required this.landmark});
}

class SetTransportModeEvent extends MapPageEvent {
  final TransportMode mode;

  SetTransportModeEvent({required this.mode});
}
