import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/position_entity.dart';
import 'package:gem_kit/position.dart';

import 'coordinates_entity_impl.dart';

class PositionEntityImpl implements PositionEntity {
  final GemPosition? ref;

  PositionEntityImpl({required this.ref});

  @override
  CoordinatesEntity getCoordinates() => CoordinatesEntityImpl(ref: ref!.coordinates);
}
