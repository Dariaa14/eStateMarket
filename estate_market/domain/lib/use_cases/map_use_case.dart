import 'package:domain/entities/wrappers/coordinates_entity.dart';

import '../entities/wrappers/landmark_entity.dart';
import '../repositories/map_repository.dart';

class MapUseCase {
  final MapRepository _mapRepository;

  MapUseCase({required MapRepository mapRepository}) : _mapRepository = mapRepository;

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
}
