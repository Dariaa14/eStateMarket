import 'package:domain/entities/wrappers/coordinates_entity.dart';

import '../entities/wrappers/landmark_entity.dart';

abstract class MapRepository {
  void startFollowingPosition();

  void registerMapGestureCallbacks(Function(LandmarkEntity) onTap);

  void centerOnCoordinates(CoordinatesEntity coordinates);

  void activateHighlight(LandmarkEntity landmark);
  void deactivateAllHighlights();

  Future<void> highlightAllProperties();
}
