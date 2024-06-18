part of 'map_page_bloc.dart';

class MapPageState extends Equatable {
  final LandmarkEntity? landmark;
  final AdEntity? ad;

  final bool hasLocationPermission;
  final bool isLocationEnabled;
  final PositionEntity? currentPosition;

  final double range;
  final TransportMode transportMode;

  const MapPageState({
    this.ad,
    this.landmark,
    this.hasLocationPermission = false,
    this.isLocationEnabled = false,
    this.currentPosition,
    this.range = 600,
    this.transportMode = TransportMode.car,
  });

  MapPageState copyWith({
    AdEntity? ad,
    LandmarkEntity? landmark,
    bool? hasLocationPermission,
    bool? isLocationEnabled,
    PositionEntity? currentPosition,
    double? range,
    TransportMode? transportMode,
  }) =>
      MapPageState(
        ad: ad ?? this.ad,
        landmark: landmark ?? this.landmark,
        hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
        isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
        currentPosition: currentPosition ?? this.currentPosition,
        range: range ?? this.range,
        transportMode: transportMode ?? this.transportMode,
      );

  MapPageState copyWithNullAd() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: currentPosition,
        landmark: landmark,
        ad: null,
        range: range,
        transportMode: transportMode,
      );

  MapPageState copyWithNullLandmark() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: currentPosition,
        landmark: null,
        ad: ad,
        range: range,
        transportMode: transportMode,
      );

  MapPageState copyWithNullPosition() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: null,
        landmark: landmark,
        ad: ad,
        range: range,
        transportMode: transportMode,
      );

  @override
  List<Object?> get props =>
      [landmark, hasLocationPermission, isLocationEnabled, currentPosition, ad, range, transportMode];
}
