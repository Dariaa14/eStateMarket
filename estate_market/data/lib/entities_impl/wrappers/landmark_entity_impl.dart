import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/wrappers/address_entity.dart' as ae;
import 'package:domain/entities/wrappers/coordinates_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:gem_kit/core.dart';
import 'address_entity_impl.dart';
import 'coordinates_entity_impl.dart';

class LandmarkEntityImpl implements LandmarkEntity {
  ae.AddressEntity? address;
  final Landmark ref;

  LandmarkEntityImpl({required this.ref}) {
    address = AddressEntityImpl(
      country: ref.address.getField(AddressField.country),
      city: ref.address.getField(AddressField.city),
      streetName: ref.address.getField(AddressField.streetName),
      streetNumber: ref.address.getField(AddressField.streetNumber),
    );
  }

  @override
  void setCoordinates(CoordinatesEntity coordinates) {
    ref.coordinates = ((coordinates as CoordinatesEntityImpl).ref);
  }

  @override
  void setName(String name) {
    ref.name = name;
  }

  @override
  String getName() => ref.name;

  @override
  String getAddressField(ae.AddressField field) {
    switch (field) {
      case ae.AddressField.country:
        return address!.getField(ae.AddressField.country);
      case ae.AddressField.city:
        return address!.getField(ae.AddressField.city);
      case ae.AddressField.streetName:
        return address!.getField(ae.AddressField.streetName);
      case ae.AddressField.streetNumber:
        return address!.getField(ae.AddressField.streetNumber);
    }
  }

  @override
  String getAddressString() {
    final country = address!.getField(ae.AddressField.country);
    final city = address!.getField(ae.AddressField.city);
    final street = address!.getField(ae.AddressField.streetName);
    final streetNumber = address!.getField(ae.AddressField.streetNumber);
    return '$country $city $street $streetNumber'.trim();
  }

  @override
  CoordinatesEntity getCoordinates() => CoordinatesEntityImpl(ref: ref.coordinates);

  LandmarkEntityImpl.create() : ref = Landmark() {
    ref.setImageFromIconId(GemIcon.searchResultsPin);
  }

  @override
  void setAddress(ae.AddressEntity address) => this.address = address;

  Map<String, dynamic> toJson() {
    return {
      'name': getName(),
      'country': getAddressField(ae.AddressField.country),
      'city': getAddressField(ae.AddressField.city),
      'streetName': getAddressField(ae.AddressField.streetName),
      'streetNumber': getAddressField(ae.AddressField.streetNumber),
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
