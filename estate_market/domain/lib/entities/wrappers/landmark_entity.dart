import 'address_entity.dart';
import 'coordinates_entity.dart';

abstract class LandmarkEntity {
  void setCoordinates(CoordinatesEntity coordinates);
  void setAddress(AddressEntity address);
  void setName(String name);

  String getName();
  String getAddressField(AddressField field);
  String getAddressString();
  CoordinatesEntity getCoordinates();
}
