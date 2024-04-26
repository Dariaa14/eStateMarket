import 'coordinates_entity.dart';

abstract class LandmarkEntity {
  void setCoordinates(CoordinatesEntity coordinates);
  void setName(String name);

  String getName();
  String getAddress();
  CoordinatesEntity getCoordinates();
}
