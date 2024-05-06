import '../entities/wrappers/position_entity.dart';

abstract class PositionRepository {
  Stream<PositionEntity?> get positionStream;

  PositionEntity? get position;

  Future<void> setLivePosition();
}
