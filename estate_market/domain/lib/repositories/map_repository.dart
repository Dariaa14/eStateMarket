import 'package:domain/entities/wrappers/coordinates_entity.dart';

import '../entities/wrappers/landmark_entity.dart';

enum LocationPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
}

abstract class MapRepository {
  void startFollowingPosition();
  Future<LocationPermissionStatus> requestLocationPermission();

  void registerMapGestureCallbacks(Function(LandmarkEntity) onTap);

  void centerOnCoordinates(CoordinatesEntity coordinates);
}
