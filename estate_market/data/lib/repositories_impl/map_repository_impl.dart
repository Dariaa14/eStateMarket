import 'dart:async';
import 'dart:math';

import 'package:data/entities_impl/wrappers/landmark_entity_impl.dart';
import 'package:data/entities_impl/wrappers/map_controller_entity_impl.dart';
import 'package:data/entities_impl/wrappers/route_entity_impl.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/entities/wrappers/map_controller_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:gem_kit/map.dart';
import 'package:gem_kit/core.dart';
import 'package:gem_kit/routing.dart';

import '../entities_impl/wrappers/collection_reference_entity_impl.dart';
import '../entities_impl/wrappers/document_reference_entity_impl.dart';

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
      final landmarks = mapController.cursorSelectionLandmarks();
      if (landmarks.isNotEmpty) {
        final landmark = landmarks.first;
        onTap(landmark);
        return;
      }

      final overlays = mapController.cursorSelectionOverlayItems();
      if (overlays.isNotEmpty) {
        final overlay = overlays.first;
        onTap(overlay);
        return;
      }

      final streets = mapController.cursorSelectionStreets();
      if (streets.isNotEmpty) {
        final street = streets.first;
        onTap(street);
        return;
      }
    });
  }

  @override
  void centerOnCoordinates(CoordinatesEntity coordinates) {
    mapController.centerOnCoordinates(coordinates);
  }

  @override
  void activateHighlight(LandmarkEntity landmark) {
    mapController.activateHighlight([landmark]);
  }

  @override
  void deactivateAllHighlights() {
    mapController.deactivateAllHighlights();
  }

  @override
  Future<void> highlightAllProperties() async {
    final landmarks = await _getLandmarksFromDatabase();

    mapController.activateHighlight(landmarks);
  }

  @override
  Future<AdEntity?> getAdOfLandmark(LandmarkEntity landmark) async {
    CollectionReferenceEntity landmarks = CollectionReferenceEntityImpl(collection: Collections.landmarks);
    final landmarkDocument = await landmarks.getDocuments();
    final landmarkEntities = await _getLandmarksFromDatabase();

    for (int index = 0; index < landmarkEntities.length; index++) {
      final distance = _calculateDistance(landmark.getCoordinates(), landmarkEntities[index].getCoordinates());
      if (distance < 100) {
        CollectionReferenceEntity ads = CollectionReferenceEntityImpl(collection: Collections.ad);
        final ad = (await ads
                .where(
                    'landmark', WhereOperations.isEqualTo, (landmarkDocument[index] as DocumentReferenceEntityImpl).ref)
                .get<AdEntity>())
            .first;
        return ad;
      }
    }

    return null;
  }

  @override
  Future<bool> calculateRoute(LandmarkEntity landmark, CoordinatesEntity currentPosition, TransportMode mode) async {
    Completer<bool> completer = Completer();

    final currentPositionLandmark = Landmark();
    currentPositionLandmark.coordinates =
        Coordinates(latitude: currentPosition.getLatitude()!, longitude: currentPosition.getLongitude()!);

    final gemLandmark = (landmark as LandmarkEntityImpl).ref;

    RoutingService.calculateRoute(
        [currentPositionLandmark, gemLandmark], RoutePreferences(transportMode: _getGemTransportMode(mode)),
        (err, result) {
      if (err != GemError.success || result == null || result.isEmpty) {
        completer.complete(false);
        return;
      }

      final route = RouteEntityImpl(ref: result.first);
      mapController.showRoute(route);
      completer.complete(true);
    });

    return completer.future;
  }

  Future<List<LandmarkEntity>> _getLandmarksFromDatabase() async {
    CollectionReferenceEntity landmarks = CollectionReferenceEntityImpl(collection: Collections.landmarks);
    return await landmarks.get<LandmarkEntity>();
  }

  double _calculateDistance(CoordinatesEntity coords1, CoordinatesEntity coords2) {
    const R = 6371e3;
    final phi1 = coords1.getLatitude()! * pi / 180;
    final phi2 = coords2.getLatitude()! * pi / 180;
    final deltaPhi = (coords2.getLatitude()! - coords1.getLatitude()!) * pi / 180;
    final deltaLambda = (coords2.getLongitude()! - coords1.getLongitude()!) * pi / 180;

    final a =
        sin(deltaPhi / 2) * sin(deltaPhi / 2) + cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }

  RouteTransportMode _getGemTransportMode(TransportMode mode) {
    switch (mode) {
      case TransportMode.car:
        return RouteTransportMode.car;
      case TransportMode.pedestrian:
        return RouteTransportMode.pedestrian;
      case TransportMode.bike:
        return RouteTransportMode.bicycle;
      default:
        throw Exception('Unknown transport mode');
    }
  }
}
