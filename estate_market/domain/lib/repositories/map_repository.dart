enum LocationPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
}

abstract class MapRepository {
  void startFollowingPosition();
  Future<LocationPermissionStatus> requestLocationPermission();
}
