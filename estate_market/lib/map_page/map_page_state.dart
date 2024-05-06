part of 'map_page_bloc.dart';

class MapPageState extends Equatable {
  final LandmarkEntity? landmark;

  final bool hasLocationPermission;
  final bool isLocationEnabled;
  final PositionEntity? currentPosition;

  const MapPageState({
    this.landmark,
    this.hasLocationPermission = false,
    this.isLocationEnabled = false,
    this.currentPosition,
  });

  MapPageState copyWith({
    LandmarkEntity? landmark,
    bool? hasLocationPermission,
    bool? isLocationEnabled,
    PositionEntity? currentPosition,
  }) =>
      MapPageState(
        landmark: landmark ?? this.landmark,
        hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
        isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
        currentPosition: currentPosition ?? this.currentPosition,
      );

  MapPageState copyWithNullLandmark() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: currentPosition,
        landmark: null,
      );

  MapPageState copyWithNullPosition() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: null,
        landmark: landmark,
      );

  @override
  List<Object?> get props => [landmark, hasLocationPermission, isLocationEnabled, currentPosition];
}
