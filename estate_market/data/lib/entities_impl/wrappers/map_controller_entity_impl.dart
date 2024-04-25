import 'dart:math';

import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/entities/wrappers/map_controller_entity.dart';
import 'package:gem_kit/api/gem_mapviewpreferences.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/gem_kit_map_controller.dart';

import 'coordinates_entity_impl.dart';
import 'landmark_entity_impl.dart';

class MapControllerEntityImpl implements MapControllerEntity {
  final GemMapController ref;

  MapControllerEntityImpl({required this.ref});

  @override
  void startFollowingPosition() {
    ref.startFollowingPosition(animation: GemAnimation(type: EAnimation.AnimationLinear));
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

  List<LandmarkEntity> _parseGemLandmarkList(LandmarkList list) {
    final List<LandmarkEntity> landmarks = [];
    for (final gemLandmark in list) {
      landmarks.add(LandmarkEntityImpl(ref: gemLandmark));
    }
    return landmarks;
  }
}
