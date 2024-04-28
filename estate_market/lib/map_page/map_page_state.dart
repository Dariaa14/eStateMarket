part of 'map_page_bloc.dart';

class MapPageState extends Equatable {
  final LocationPermissionStatus status;
  final LandmarkEntity? landmark;

  const MapPageState({this.status = LocationPermissionStatus.denied, this.landmark});

  MapPageState copyWith({LocationPermissionStatus? status, LandmarkEntity? landmark}) {
    return MapPageState(
      status: status ?? this.status,
      landmark: landmark ?? this.landmark,
    );
  }

  @override
  List<Object?> get props => [status, landmark];
}
