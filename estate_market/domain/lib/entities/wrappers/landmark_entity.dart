import 'coordinates_entity.dart';

enum AddressField { country, city, streetName, streetNumber }

abstract class LandmarkEntity {
  void setCoordinates(CoordinatesEntity coordinates);
  void setAddressField(String value, AddressField field);
  void setName(String name);

  String getName();
  String getAddressString();
  CoordinatesEntity getCoordinates();
}
