part of 'map_page_bloc.dart';

abstract class MapPageEvent {}

class RequestLocationPermissionEvent extends MapPageEvent {}

class FollowPositionEvent extends MapPageEvent {}

class InitAddressSelectionEvent extends MapPageEvent {}

class InitViewLandmarkEvent extends MapPageEvent {
  final LandmarkEntity landmark;

  InitViewLandmarkEvent({required this.landmark});
}
