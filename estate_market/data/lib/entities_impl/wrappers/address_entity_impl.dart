import 'package:domain/entities/wrappers/address_entity.dart';

class AddressEntityImpl implements AddressEntity {
  String country;
  String city;
  String streetName;
  String streetNumber;

  AddressEntityImpl({this.country = '', this.city = '', this.streetName = '', this.streetNumber = ''});

  @override
  String getField(AddressField field) {
    switch (field) {
      case AddressField.country:
        return country;
      case AddressField.city:
        return city;
      case AddressField.streetName:
        return streetName;
      case AddressField.streetNumber:
        return streetNumber;
    }
  }

  @override
  void setField(String value, AddressField field) {
    switch (field) {
      case AddressField.country:
        country = value;
        break;
      case AddressField.city:
        city = value;
        break;
      case AddressField.streetName:
        streetName = value;
        break;
      case AddressField.streetNumber:
        streetNumber = value;
        break;
    }
  }
}
