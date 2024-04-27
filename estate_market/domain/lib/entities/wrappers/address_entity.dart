enum AddressField { country, city, streetName, streetNumber }

abstract class AddressEntity {
  String getField(AddressField field);
  void setField(String value, AddressField field);
}
