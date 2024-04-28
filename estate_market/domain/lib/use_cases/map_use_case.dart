import 'package:domain/entities/wrappers/coordinates_entity.dart';

import '../entities/wrappers/landmark_entity.dart';
import '../repositories/map_repository.dart';

class MapUseCase {
  final MapRepository _mapRepository;

  MapUseCase({required MapRepository mapRepository}) : _mapRepository = mapRepository;

  void startFollowingPosition() {
    _mapRepository.startFollowingPosition();
  }

  Future<LocationPermissionStatus> requestLocationPermission() async {
    return await _mapRepository.requestLocationPermission();
  }

  void registerMapGestureCallbacks(Function(LandmarkEntity) onTap) {
    _mapRepository.registerMapGestureCallbacks(onTap);
  }

  void centerOnCoordinates(CoordinatesEntity coordinates) {
    _mapRepository.centerOnCoordinates(coordinates);
  }
}
