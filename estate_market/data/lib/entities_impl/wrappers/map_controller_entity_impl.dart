import 'dart:math';
import 'dart:ui';

import 'package:data/entities_impl/wrappers/route_entity_impl.dart';
import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/entities/wrappers/map_controller_entity.dart';
import 'package:domain/entities/wrappers/route_entity.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/map.dart';

import 'coordinates_entity_impl.dart';
import 'landmark_entity_impl.dart';

class MapControllerEntityImpl implements MapControllerEntity {
  final GemMapController ref;

  MapControllerEntityImpl({required this.ref});

  @override
  void startFollowingPosition() {
    ref.startFollowingPosition(animation: GemAnimation(type: Animation.linear));
  }

  @override
  void registerTouchCallback(Function(Point<num>) callback) {
    ref.registerTouchCallback(callback);
  }

  @override
  Future<void> selectMapObjects(Point<num> pos) async {
    await ref.selectMapObjects(pos);
  }

  @override
  List<LandmarkEntity> cursorSelectionLandmarks() {
    final gemLandmarks = ref.cursorSelectionLandmarks();
    return _parseGemLandmarkList(gemLandmarks);
  }

  @override
  List<LandmarkEntity> cursorSelectionOverlayItems() {
    final overlays = ref.cursorSelectionOverlayItems();
    return _parseGemLandmarkList(overlays);
  }

  @override
  List<LandmarkEntity> cursorSelectionStreets() {
    final streets = ref.cursorSelectionStreets();
    return _parseGemLandmarkList(streets);
  }

  @override
  CoordinatesEntity? transformScreenToCoordinates(Point<num> pos) {
    final gemCoordinates = ref.transformScreenToWgs(XyType(x: pos.x as int, y: pos.y as int));
    if (gemCoordinates == null) return null;
    return CoordinatesEntityImpl(ref: gemCoordinates);
  }

  List<LandmarkEntity> _parseGemLandmarkList(List<Landmark> list) {
    final List<LandmarkEntity> landmarks = [];
    for (final gemLandmark in list) {
      landmarks.add(LandmarkEntityImpl(ref: gemLandmark));
    }
    return landmarks;
  }

  @override
  void centerOnCoordinates(CoordinatesEntity coordinates) {
    ref.centerOnCoordinates((coordinates as CoordinatesEntityImpl).ref,
        animation: GemAnimation(type: Animation.linear));
  }

  @override
  void deactivateAllHighlights() {
    ref.deactivateAllHighlights();
  }

  @override
  void activateHighlight(List<LandmarkEntity> landmarks) {
    final List<Landmark> landmarksToHighlight = [];

    for (final landmark in landmarks) {
      final gemLandmark = (landmark as LandmarkEntityImpl).ref;
      gemLandmark.setImageFromIconId(GemIcon.searchResultsPin);

      landmarksToHighlight.add(gemLandmark);
    }

    ref.activateHighlight(landmarksToHighlight);
  }

  @override
  void showRange(RouteEntity route) {
    if (ref.preferences.routes.isNotEmpty) {
      ref.preferences.routes.clear();
    }

    RouteRenderSettings renderSettings = RouteRenderSettings(fillColor: Color(0xFFFF9000));
    ref.preferences.routes.add((route as RouteEntityImpl).ref, true, routeRenderSettings: renderSettings);
  }
}
