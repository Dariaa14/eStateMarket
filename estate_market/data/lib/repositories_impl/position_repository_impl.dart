import 'package:data/entities_impl/wrappers/position_entity_impl.dart';
import 'package:domain/entities/wrappers/position_entity.dart';
import 'package:domain/repositories/position_repository.dart';
import 'package:gem_kit/sense.dart';
import 'package:rxdart/rxdart.dart';

class PositionRepositoryImpl implements PositionRepository {
  final BehaviorSubject<PositionEntity?> _positionStreamController = BehaviorSubject.seeded(null);

  @override
  Stream<PositionEntity?> get positionStream => _positionStreamController.stream;

  @override
  PositionEntity? get position => _positionStreamController.stream.value;

  @override
  Future<void> setLivePosition() async {
    await PositionService.instance.setLiveDataSource().then((value) async {
      _initializeFirstPosition();
      _listenForPositionUpdate();
    });
  }

  void _listenForPositionUpdate() => PositionService.instance.addImprovedPositionListenerffi((gemPosition) {
        final positionEntity = PositionEntityImpl(ref: gemPosition);
        _positionStreamController.add(positionEntity);
      });

  void _initializeFirstPosition() {
    final initialPosition = PositionService.instance.getPosition();
    final positionEntity = PositionEntityImpl(ref: initialPosition);
    _positionStreamController.add(positionEntity);
  }
}
