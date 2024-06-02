part of 'map_page_bloc.dart';

class MapPageState extends Equatable {
  final LandmarkEntity? landmark;
  final AdEntity? ad;

  final bool hasLocationPermission;
  final bool isLocationEnabled;
  final PositionEntity? currentPosition;

  const MapPageState({
    this.ad,
    this.landmark,
    this.hasLocationPermission = false,
    this.isLocationEnabled = false,
    this.currentPosition,
  });

  MapPageState copyWith({
    AdEntity? ad,
    LandmarkEntity? landmark,
    bool? hasLocationPermission,
    bool? isLocationEnabled,
    PositionEntity? currentPosition,
  }) =>
      MapPageState(
        ad: ad ?? this.ad,
        landmark: landmark ?? this.landmark,
        hasLocationPermission: hasLocationPermission ?? this.hasLocationPermission,
        isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
        currentPosition: currentPosition ?? this.currentPosition,
      );

  MapPageState copyWithNullAd() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: currentPosition,
        landmark: landmark,
        ad: null,
      );

  MapPageState copyWithNullLandmark() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: currentPosition,
        landmark: null,
        ad: ad,
      );

  MapPageState copyWithNullPosition() => MapPageState(
        hasLocationPermission: hasLocationPermission,
        isLocationEnabled: isLocationEnabled,
        currentPosition: null,
        landmark: landmark,
        ad: ad,
      );

  @override
  List<Object?> get props => [landmark, hasLocationPermission, isLocationEnabled, currentPosition, ad];
}
