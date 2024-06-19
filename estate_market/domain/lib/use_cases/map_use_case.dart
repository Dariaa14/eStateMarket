import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/repositories/position_repository.dart';

import '../entities/wrappers/landmark_entity.dart';
import '../repositories/map_repository.dart';

class MapUseCase {
  final MapRepository _mapRepository;
  final PositionRepository _positionRepository;

  MapUseCase({required MapRepository mapRepository, required PositionRepository positionRepository})
      : _mapRepository = mapRepository,
        _positionRepository = positionRepository;

  void startFollowingPosition() {
    _mapRepository.startFollowingPosition();
  }

  void registerMapGestureCallbacks(Function(LandmarkEntity) onTap) {
    _mapRepository.registerMapGestureCallbacks(onTap);
  }

  void centerOnCoordinates(CoordinatesEntity coordinates) {
    _mapRepository.centerOnCoordinates(coordinates);
  }

  void activateHighlight(LandmarkEntity landmark) {
    _mapRepository.activateHighlight(landmark);
  }

  void deactivateAllHighlights() {
    _mapRepository.deactivateAllHighlights();
  }

  Future<void> highlightAllProperties() {
    return _mapRepository.highlightAllProperties();
  }

  Future<AdEntity?> getAdOfLandmark(LandmarkEntity landmark) {
    return _mapRepository.getAdOfLandmark(landmark);
  }

  Future<bool> calculateRoute(LandmarkEntity landmark, TransportMode mode) async {
    if (_positionRepository.position == null) {
      return false;
    }
    return await _mapRepository.calculateRoute(landmark, _positionRepository.position!.getCoordinates(), mode);
  }
}
