import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:gem_kit/core.dart';
import 'coordinates_entity_impl.dart';

class LandmarkEntityImpl implements LandmarkEntity {
  final Landmark ref;

  LandmarkEntityImpl({required this.ref});

  @override
  void setCoordinates(CoordinatesEntity coordinates) {
    ref.setCoordinates((coordinates as CoordinatesEntityImpl).ref);
  }

  @override
  void setName(String name) {
    ref.setName(name);
  }

  static create() {
    final landmark = Landmark.create();
    landmark.setImageFromIconId(GemIcon.Search_Results_Pin);
    return LandmarkEntityImpl(ref: landmark);
  }
}
