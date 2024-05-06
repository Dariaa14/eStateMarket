import 'package:domain/repositories/permission_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:rxdart/rxdart.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  final Map<PermissionType, AccessStatus> _permissionTypeToStatus = {
    PermissionType.locationWhenInUse: AccessStatus.denied,
  };

  final Map<PermissionType, BehaviorSubject<AccessStatus>> _permissionStatusControllers = {
    for (var permissionType in PermissionType.values)
      permissionType: BehaviorSubject<AccessStatus>.seeded(
        AccessStatus.denied,
      ),
  };

  final BehaviorSubject<bool> _locationStatusStreamController = BehaviorSubject();
  late bool _isLocationEnabled;

  PermissionRepositoryImpl() {
    gl.Geolocator.isLocationServiceEnabled().then((value) {
      _isLocationEnabled = value;
      _locationStatusStreamController.sink.add(_isLocationEnabled);
    });

    gl.Geolocator.getServiceStatusStream().listen((status) {
      switch (status) {
        case gl.ServiceStatus.enabled:
          _isLocationEnabled = true;
          break;
        case gl.ServiceStatus.disabled:
          _isLocationEnabled = false;
          break;
      }
      _locationStatusStreamController.sink.add(_isLocationEnabled);
    });

    _updateAccessStatus(PermissionType.locationWhenInUse);
  }

  @override
  Stream<AccessStatus> permissionStream(PermissionType permissionType) =>
      _permissionStatusControllers[permissionType]!.stream;

  @override
  Future<bool> askPermission(PermissionType permissionType) async {
    final locationPermissionStatus = getAccessStatus(permissionType);

    if (locationPermissionStatus == AccessStatus.permanentlyDenied) {
      await openAppSettings();
      final status = getAccessStatus(permissionType);
      return status == AccessStatus.granted;
    }

    var currentStatus = locationPermissionStatus;

    if (currentStatus != AccessStatus.granted) {
      await _request(permissionType);
      currentStatus = getAccessStatus(permissionType);
    }

    return currentStatus == AccessStatus.granted;
  }

  Future<AccessStatus> _request(PermissionType permissionType) async {
    final permission = _toPermission(permissionType);

    if (permission == null) {
      return AccessStatus.denied;
    }

    final permissionGranted = await permission.isGranted;

    if (!permissionGranted) {
      await permission.request();
    }

    await _updateAccessStatus(permissionType);

    return getAccessStatus(permissionType);
  }

  Future<void> _updateAccessStatus(PermissionType permissionType) async {
    final permission = _toPermission(permissionType);

    if (permission == null) return;

    final oldStatus = getAccessStatus(permissionType);
    final permissionStatus = await permission.status;

    final newStatus = _toAccessStatus(permissionStatus);

    if (newStatus != null && newStatus != oldStatus) {
      _permissionTypeToStatus[permissionType] = newStatus;

      _permissionStatusControllers[permissionType]!.add(newStatus);
    }
  }

  Permission? _toPermission(PermissionType permissionType) {
    switch (permissionType) {
      case PermissionType.locationWhenInUse:
        return Permission.locationWhenInUse;
      default:
        return null;
    }
  }

  AccessStatus? _toAccessStatus(PermissionStatus permissionStatus) {
    switch (permissionStatus) {
      case PermissionStatus.granted:
        return AccessStatus.granted;
      case PermissionStatus.restricted:
        return AccessStatus.restricted;
      case PermissionStatus.permanentlyDenied:
        return AccessStatus.permanentlyDenied;
      case PermissionStatus.denied:
        return AccessStatus.denied;
      default:
        return null;
    }
  }

  @override
  AccessStatus getAccessStatus(PermissionType permissionType) => _permissionTypeToStatus[permissionType]!;

  @override
  bool isGranted(PermissionType permissionType) => getAccessStatus(permissionType) == AccessStatus.granted;

  @override
  bool isPermanentlyDenied(PermissionType permissionType) =>
      getAccessStatus(permissionType) == AccessStatus.permanentlyDenied;

  @override
  bool isDenied(PermissionType permissionType) => getAccessStatus(permissionType) == AccessStatus.denied;

  @override
  bool isRestricted(PermissionType permissionType) => getAccessStatus(permissionType) == AccessStatus.restricted;

  @override
  Future<void> dispose() async {
    for (var controller in _permissionStatusControllers.values) {
      await controller.close();
    }
  }

  @override
  bool get isLocationEnabled => _isLocationEnabled;

  @override
  Stream<bool> get locationStatusStream => _locationStatusStreamController.stream;

  @override
  Future<void> updatePermissionsStatus() async => await _updateAccessStatus(PermissionType.locationWhenInUse);

  @override
  Future<bool> openLocationService() async {
    return await gl.Geolocator.openLocationSettings();
  }
}
