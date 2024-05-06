import 'package:data/entities_impl/wrappers/landmark_entity_impl.dart';
import 'package:data/entities_impl/wrappers/map_controller_entity_impl.dart';
import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/entities/wrappers/map_controller_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:gem_kit/d3Scene.dart';

class MapRepositoryImpl implements MapRepository {
  final MapControllerEntity mapController;

  MapRepositoryImpl({required GemMapController controller}) : mapController = MapControllerEntityImpl(ref: controller);

  @override
  void startFollowingPosition() {
    mapController.startFollowingPosition();
  }

  @override
  void registerMapGestureCallbacks(Function(LandmarkEntity) onTap) {
    mapController.registerTouchCallback((pos) async {
      await mapController.selectMapObjects(pos);
      //final landmarks = mapController.cursorSelectionLandmarks();
      // if (landmarks.isNotEmpty) {
      //   final landmark = landmarks.first;
      //   onTap(landmark);
      //   return;
      // }

      // final overlays = mapController.cursorSelectionOverlayItems();
      // if (overlays.isNotEmpty) {
      //   final overlay = overlays.first;
      //   onTap(overlay);
      //   return;
      // }

      final streets = mapController.cursorSelectionStreets();
      if (streets.isNotEmpty) {
        final street = streets.first;
        onTap(street);
        return;
      }

      final coordinates = mapController.transformScreenToCoordinates(pos);
      if (coordinates == null) return;

      LandmarkEntityImpl landmark = LandmarkEntityImpl.create();
      landmark.setCoordinates(coordinates);
      landmark.setName('GPS Coordinates');
      onTap(landmark);
    });
  }

  @override
  void centerOnCoordinates(CoordinatesEntity coordinates) {
    mapController.centerOnCoordinates(coordinates);
  }
}
