import 'package:domain/entities/wrappers/position_entity.dart';
import 'package:gem_kit/position.dart';

class PositionEntityImpl implements PositionEntity {
  final GemPosition? ref;

  PositionEntityImpl({required this.ref});
}
