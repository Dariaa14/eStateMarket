import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/coordinates_entity.dart';

import '../entities/wrappers/landmark_entity.dart';

enum TransportMode { car, pedestrian, bike }

abstract class MapRepository {
  void startFollowingPosition();

  void registerMapGestureCallbacks(Function(LandmarkEntity) onTap);

  void centerOnCoordinates(CoordinatesEntity coordinates);

  void activateHighlight(LandmarkEntity landmark);
  void deactivateAllHighlights();

  Future<void> highlightAllProperties();

  Future<AdEntity?> getAdOfLandmark(LandmarkEntity landmark);

  void calculateRange(LandmarkEntity landmark, TransportMode mode, int range);
}
