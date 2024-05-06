enum AccessStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
}

enum PermissionType {
  locationWhenInUse,
}

abstract class PermissionRepository {
  Stream<AccessStatus> permissionStream(PermissionType permissionType);
  Future<bool> askPermission(PermissionType permissionType);
  AccessStatus getAccessStatus(PermissionType permissionType);

  bool isGranted(PermissionType permissionType);
  bool isPermanentlyDenied(PermissionType permissionType);
  bool isDenied(PermissionType permissionType);
  bool isRestricted(PermissionType permissionType);

  Future<void> dispose();

  bool get isLocationEnabled;
  Stream<bool> get locationStatusStream;

  Future<void> updatePermissionsStatus();

  Future<bool> openLocationService();
}
