part of 'map_page_bloc.dart';

class MapPageState extends Equatable {
  final LocationPermissionStatus status;
  final LandmarkEntity? landmark;

  const MapPageState({this.status = LocationPermissionStatus.denied, this.landmark});

  MapPageState copyWith({LocationPermissionStatus? status, LandmarkEntity? landmark}) => MapPageState(
        status: status ?? this.status,
        landmark: landmark ?? this.landmark,
      );

  MapPageState copyWithNullLandmark() => MapPageState(
        status: status,
        landmark: null,
      );

  @override
  List<Object?> get props => [status, landmark];
}
