import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/wrappers/address_entity.dart';
import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:gem_kit/api/gem_addressinfo.dart';
import 'package:gem_kit/core.dart';
import 'address_entity_impl.dart';
import 'coordinates_entity_impl.dart';

class LandmarkEntityImpl implements LandmarkEntity {
  AddressEntity? address;
  final Landmark ref;

  LandmarkEntityImpl({required this.ref}) {
    address = AddressEntityImpl(
      country: ref.getAddress().getField(EAddressField.Country),
      city: ref.getAddress().getField(EAddressField.City),
      streetName: ref.getAddress().getField(EAddressField.StreetName),
      streetNumber: ref.getAddress().getField(EAddressField.StreetNumber),
    );
  }

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
  String getAddressField(AddressField field) {
    switch (field) {
      case AddressField.country:
        return address!.getField(AddressField.country);
      case AddressField.city:
        return address!.getField(AddressField.city);
      case AddressField.streetName:
        return address!.getField(AddressField.streetName);
      case AddressField.streetNumber:
        return address!.getField(AddressField.streetNumber);
    }
  }

  @override
  String getAddressString() {
    final country = address!.getField(AddressField.country);
    final city = address!.getField(AddressField.city);
    final street = address!.getField(AddressField.streetName);
    final streetNumber = address!.getField(AddressField.streetNumber);
    return '$country $city $street $streetNumber'.trim();
  }

  @override
  CoordinatesEntity getCoordinates() => CoordinatesEntityImpl(ref: ref.getCoordinates());

  LandmarkEntityImpl.create() : ref = Landmark.create() {
    ref.setImageFromIconId(GemIcon.Search_Results_Pin);
  }

  @override
  void setAddress(AddressEntity address) => this.address = address;

  Map<String, dynamic> toJson() {
    return {
      'name': getName(),
      'country': getAddressField(AddressField.country),
      'city': getAddressField(AddressField.city),
      'streetName': getAddressField(AddressField.streetName),
      'streetNumber': getAddressField(AddressField.streetNumber),
      'latitude': getCoordinates().getLatitude(),
      'longitude': getCoordinates().getLongitude(),
    };
  }

  factory LandmarkEntityImpl.fromJson(Map<String, Object?> json) {
    final landmark = LandmarkEntityImpl.create();
    landmark.setName(json['name'] as String);

    final landmarkAddress = AddressEntityImpl(
        country: json['country'] as String,
        city: json['city'] as String,
        streetName: json['streetName'] as String,
        streetNumber: json['streetNumber'] as String);
    landmark.setAddress(landmarkAddress);

    landmark.setCoordinates(CoordinatesEntityImpl.create(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    ));
    return landmark;
  }

  static Future<LandmarkEntity?> getLandmarkFromDocument(DocumentReference<Map<String, dynamic>> document) async {
    final landmark = await document.get();
    return LandmarkEntityImpl.fromJson(landmark.data()!);
  }
}
