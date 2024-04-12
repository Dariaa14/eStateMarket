import 'package:data/entities_impl/wrappers/map_controller_entity_impl.dart';
import 'package:domain/entities/wrappers/map_controller_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:gem_kit/d3Scene.dart';
import 'package:permission_handler/permission_handler.dart';

// COMPLETE FOLLOW POSITION:
class MapRepositoryImpl implements MapRepository {
  final MapControllerEntity mapController;

  MapRepositoryImpl({required GemMapController controller}) : mapController = MapControllerEntityImpl(ref: controller);

  @override
  void startFollowingPosition() {
    mapController.startFollowingPosition();
  }

  @override
  Future<LocationPermissionStatus> requestLocationPermission() async {
    final currentStatus = _parsePermissionStatus(await Permission.locationWhenInUse.request());
    return currentStatus;
  }

  _parsePermissionStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return LocationPermissionStatus.granted;
      case PermissionStatus.denied:
        return LocationPermissionStatus.denied;
      case PermissionStatus.permanentlyDenied:
        return LocationPermissionStatus.permanentlyDenied;
      default:
        return LocationPermissionStatus.denied;
    }
  }
}
