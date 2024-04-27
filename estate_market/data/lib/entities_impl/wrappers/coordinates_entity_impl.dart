import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:gem_kit/core.dart';

class CoordinatesEntityImpl implements CoordinatesEntity {
  final Coordinates ref;

  CoordinatesEntityImpl({required this.ref});

  CoordinatesEntityImpl.create({required double latitude, required double longitude})
      : ref = Coordinates(latitude: latitude, longitude: longitude);

  @override
  double? getLatitude() => ref.latitude;

  @override
  double? getLongitude() => ref.longitude;
}
