import 'package:domain/entities/wrappers/map_controller_entity.dart';
import 'package:gem_kit/api/gem_mapviewpreferences.dart';
import 'package:gem_kit/gem_kit_map_controller.dart';

class MapControllerEntityImpl implements MapControllerEntity {
  final GemMapController ref;

  MapControllerEntityImpl({required this.ref});

  @override
  void startFollowingPosition() {
    ref.startFollowingPosition(animation: GemAnimation(type: EAnimation.AnimationLinear));
  }
}
