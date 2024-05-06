import 'package:rxdart/rxdart.dart';

import '../entities/wrappers/position_entity.dart';
import '../repositories/permission_repository.dart';
import '../repositories/position_repository.dart';

class LocationUseCase {
  final PermissionRepository _permissionRepository;
  final PositionRepository _positionRepository;
  final BehaviorSubject<bool> _locationPermissionStreamController = BehaviorSubject();

  LocationUseCase({required PermissionRepository permissionRepository, required PositionRepository positionRepository})
      : _permissionRepository = permissionRepository,
        _positionRepository = positionRepository;

  Stream<PositionEntity?> get positionStream => _positionRepository.positionStream;
  Stream<bool> get locationStatusStream => _permissionRepository.locationStatusStream;
  Stream<bool> get locationPermissionStream => _locationPermissionStreamController.stream;

  PositionEntity? get position => _positionRepository.position;

  initialize() {
    _permissionRepository.permissionStream(PermissionType.locationWhenInUse).listen((event) async {
      if (event == AccessStatus.granted) {
        await _positionRepository.setLivePosition();
      }
      _locationPermissionStreamController.add(event == AccessStatus.granted);
    });
  }

  bool get hasPosition => position != null;

  bool get hasLocationPermission => _permissionRepository.isGranted(PermissionType.locationWhenInUse);

  bool get isLocationEnabled => _permissionRepository.isLocationEnabled;

  Future<void> updatePermissionsStatus() async => await _permissionRepository.updatePermissionsStatus();

  Future<bool> askLocationPermission() async {
    bool hasGrantedPermission = _permissionRepository.isGranted(PermissionType.locationWhenInUse);

    if (!hasGrantedPermission) {
      hasGrantedPermission = await _permissionRepository.askPermission(PermissionType.locationWhenInUse);
    }
    return hasGrantedPermission;
  }

  Future<bool> openLocationService() async => await _permissionRepository.openLocationService();
}
