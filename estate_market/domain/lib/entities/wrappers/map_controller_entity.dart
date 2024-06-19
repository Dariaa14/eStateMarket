import 'dart:math';

import 'package:domain/entities/wrappers/coordinates_entity.dart';

import 'landmark_entity.dart';
import 'route_entity.dart';

abstract class MapControllerEntity {
  void startFollowingPosition();

  void registerTouchCallback(Function(Point<num>) callback);
  Future<void> selectMapObjects(Point<num> pos);

  List<LandmarkEntity> cursorSelectionLandmarks();
  List<LandmarkEntity> cursorSelectionOverlayItems();
  List<LandmarkEntity> cursorSelectionStreets();

  CoordinatesEntity? transformScreenToCoordinates(Point<num> pos);

  void centerOnCoordinates(CoordinatesEntity coordinates);

  void activateHighlight(List<LandmarkEntity> landmarks);
  void deactivateAllHighlights();

  void showRoute(RouteEntity route);
}
