part of 'map_page_bloc.dart';

class MapPageState extends Equatable {
  final LandmarkEntity? landmark;
  final AdEntity? ad;

  final bool hasLocationPermission;
  final bool isLocationEnabled;
  final PositionEntity? currentPosition;

  final TransportMode transportMode;
  final bool wasRouteCalculated;

  const MapPageState({
    this.ad,
    this.landmark,
    this.hasLocationPermission = false,
    this.isLocationEnabled = false,
    this.currentPosition,
    this.transportMode = TransportMode.car,
    this.wasRouteCalculated = false,
  });

  MapPageState copyWith({
    AdEntity? ad,
    LandmarkEntity? landmark,
    bool? hasLocationPermission,
    bool? isLocationEnabled,
    PositionEntity? currentPosition,
    TransportMode? transportMode,
    bool? wasRouteCalculated,
  }) =>
      MapPageState(
        ad: ad ?? this.ad,
        landmark: landmark ?? this.landmark,
        hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
        isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
        currentPosition: currentPosition ?? this.currentPosition,
        transportMode: transportMode ?? this.transportMode,
        wasRouteCalculated: wasRouteCalculated ?? this.wasRouteCalculated,
      );

  MapPageState copyWithNullAd() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: currentPosition,
        landmark: landmark,
        ad: null,
        transportMode: transportMode,
        wasRouteCalculated: wasRouteCalculated,
      );

  MapPageState copyWithNullLandmark() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: currentPosition,
        landmark: null,
        ad: ad,
        transportMode: transportMode,
        wasRouteCalculated: wasRouteCalculated,
      );

  MapPageState copyWithNullPosition() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: null,
        landmark: landmark,
        ad: ad,
        transportMode: transportMode,
        wasRouteCalculated: wasRouteCalculated,
      );

  @override
  List<Object?> get props =>
      [landmark, hasLocationPermission, isLocationEnabled, currentPosition, ad, transportMode, wasRouteCalculated];
}
