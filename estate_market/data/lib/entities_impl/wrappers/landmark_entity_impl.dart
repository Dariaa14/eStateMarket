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
  String getAddressString() {
    final address = ref.getAddress();
    final country = address.getField(EAddressField.Country);
    final city = address.getField(EAddressField.City);
    final street = address.getField(EAddressField.StreetName);
    final streetNumber = address.getField(EAddressField.StreetNumber);
    return '$country $city $street $streetNumber'.trim();
  }

  @override
  CoordinatesEntity getCoordinates() => CoordinatesEntityImpl(ref: ref.getCoordinates());

  LandmarkEntityImpl.create() : ref = Landmark.create() {
    ref.setImageFromIconId(GemIcon.Search_Results_Pin);
  }

  @override
  void setAddressField(String value, AddressField field) {
    final address = ref.getAddress();
    switch (field) {
      case AddressField.country:
        address.setField(value, EAddressField.Country);
        break;
      case AddressField.city:
        address.setField(value, EAddressField.City);
        break;
      case AddressField.streetName:
        address.setField(value, EAddressField.StreetName);
        break;
      case AddressField.streetNumber:
        address.setField(value, EAddressField.StreetNumber);
        break;
    }
  }
}
