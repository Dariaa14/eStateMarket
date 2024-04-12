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
}
