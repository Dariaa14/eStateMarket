import 'package:data/entities_impl/account_entity_impl.dart';
import 'package:data/entities_impl/property_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/property_entity.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';

import 'wrappers/document_reference_entity_impl.dart';
import 'wrappers/landmark_entity_impl.dart';

class AdEntityImpl implements AdEntity {
  DocumentReferenceEntity? _propertyReference;
  DocumentReferenceEntity? _accountReference;
  DocumentReferenceEntity? _landmarkReference;

  @override
  PropertyEntity? property;

  @override
  AccountEntity? account;

  @override
  AdCategory adCategory;

  @override
  DateTime dateOfAd;

  @override
  String description;

  @override
  List<String> imagesUrls;

  @override
  ListingType listingType;

  @override
  String title;

  @override
  LandmarkEntity? landmark;

  AdEntityImpl(
      {required this.title,
      required this.adCategory,
      required this.imagesUrls,
      required this.description,
      this.property,
      this.account,
      required this.listingType,
      required this.dateOfAd,
      required DocumentReferenceEntity? propertyReference,
      required DocumentReferenceEntity? accountReference,
      required DocumentReferenceEntity? landmarkReference})
      : _propertyReference = propertyReference,
        _accountReference = accountReference,
        _landmarkReference = landmarkReference;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'adCategory': adCategory.index,
      'images': imagesUrls,
      'description': description,
      'property': (_propertyReference as DocumentReferenceEntityImpl).ref,
      'account': (_accountReference as DocumentReferenceEntityImpl).ref,
      'landmark': (_landmarkReference as DocumentReferenceEntityImpl).ref,
      'listingType': listingType.index,
      'dateOfAd': Timestamp.fromDate(dateOfAd),
    };
  }

  factory AdEntityImpl.fromJson(Map<String, Object?> json) {
    return AdEntityImpl(
      title: json['title'] as String,
      adCategory: AdCategory.values[json['adCategory'] as int],
      imagesUrls: (json.containsKey('images'))
          ? ((json['images'] as List).isEmpty
              ? List<String>.empty()
              : (json['images'] as List<dynamic>).map((dynamic item) => item.toString()).toList())
          : List<String>.empty(),
      description: json['description'] as String,
      listingType: ListingType.values[json['listingType'] as int],
      dateOfAd: (json['dateOfAd'] as Timestamp).toDate(),
      propertyReference: (json.containsKey('property'))
          ? DocumentReferenceEntityImpl(ref: json['property'] as DocumentReference<Map<String, dynamic>>)
          : null,
      accountReference: (json.containsKey('account'))
          ? DocumentReferenceEntityImpl(ref: json['account'] as DocumentReference<Map<String, dynamic>>)
          : null,
      landmarkReference: (json.containsKey('landmark'))
          ? DocumentReferenceEntityImpl(ref: json['landmark'] as DocumentReference<Map<String, dynamic>>)
          : null,
    );
  }

  @override
  Future<void> setReferences() async {
    if (_propertyReference == null) return;
    PropertyEntity? property = await PropertyEntityImpl.getPropertyFromDocument(
        (_propertyReference! as DocumentReferenceEntityImpl).ref as DocumentReference<Map<String, dynamic>>);
    this.property = property;

    if (_accountReference == null) return;
    AccountEntity? account = await AccountEntityImpl.getAccountFromDocument(
        (_accountReference! as DocumentReferenceEntityImpl).ref as DocumentReference<Map<String, dynamic>>);
    this.account = account;

    if (_landmarkReference == null) return;
    LandmarkEntity? landmark = await LandmarkEntityImpl.getLandmarkFromDocument(
        (_landmarkReference! as DocumentReferenceEntityImpl).ref as DocumentReference<Map<String, dynamic>>);
    this.landmark = landmark;
  }

  static Future<AdEntity?> getAdFromDocument(DocumentReferenceEntity document) async {
    final firebaseDocument = (document as DocumentReferenceEntityImpl).ref as DocumentReference<Map<String, dynamic>>;
    final adDocument = await firebaseDocument.get();
    final ad = AdEntityImpl.fromJson(adDocument.data()!);
    await ad.setReferences();
    return ad;
  }
}
