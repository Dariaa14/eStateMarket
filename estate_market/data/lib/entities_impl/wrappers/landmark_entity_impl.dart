import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:gem_kit/api/gem_addressinfo.dart';
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

  @override
  String getName() => ref.getName();

  @override
  String getAddress() {
    final address = ref.getAddress();
    final country = address.getField(EAddressField.Country);
    final city = address.getField(EAddressField.City);
    final street = address.getField(EAddressField.StreetName);
    final streetNumber = address.getField(EAddressField.StreetNumber);
    return '$country $city $street $streetNumber'.trim();
  }

  @override
  CoordinatesEntity getCoordinates() => CoordinatesEntityImpl(ref: ref.getCoordinates());

  static create() {
    final landmark = Landmark.create();
    landmark.setImageFromIconId(GemIcon.Search_Results_Pin);
    return LandmarkEntityImpl(ref: landmark);
  }
}
