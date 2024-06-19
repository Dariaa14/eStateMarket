// Mocks generated by Mockito 5.4.4 from annotations
// in domain/test/domain_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:domain/entities/account_entity.dart' as _i4;
import 'package:domain/entities/ad_entity.dart' as _i5;
import 'package:domain/entities/property_entity.dart' as _i8;
import 'package:domain/entities/wrappers/document_reference_entity.dart' as _i2;
import 'package:domain/entities/wrappers/landmark_entity.dart' as _i9;
import 'package:domain/repositories/account_repository.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDateTime_0 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDocumentReferenceEntity_1 extends _i1.SmartFake
    implements _i2.DocumentReferenceEntity {
  _FakeDocumentReferenceEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AccountRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountRepository extends _i1.Mock implements _i3.AccountRepository {
  MockAccountRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set currentAccount(_i4.AccountEntity? _currentAccount) => super.noSuchMethod(
        Invocation.setter(
          #currentAccount,
          _currentAccount,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set currentAccountDocument(
          _i2.DocumentReferenceEntity? _currentAccountDocument) =>
      super.noSuchMethod(
        Invocation.setter(
          #currentAccountDocument,
          _currentAccountDocument,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set favoriteAds(List<_i5.AdEntity>? _favoriteAds) => super.noSuchMethod(
        Invocation.setter(
          #favoriteAds,
          _favoriteAds,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Stream<_i4.AccountEntity?> get accountStream => (super.noSuchMethod(
        Invocation.getter(#accountStream),
        returnValue: _i6.Stream<_i4.AccountEntity?>.empty(),
      ) as _i6.Stream<_i4.AccountEntity?>);

  @override
  _i6.Stream<List<_i5.AdEntity>?> get favoriteAdsStream => (super.noSuchMethod(
        Invocation.getter(#favoriteAdsStream),
        returnValue: _i6.Stream<List<_i5.AdEntity>?>.empty(),
      ) as _i6.Stream<List<_i5.AdEntity>?>);

  @override
  _i6.Stream<List<_i5.AdEntity?>> get myAdsStream => (super.noSuchMethod(
        Invocation.getter(#myAdsStream),
        returnValue: _i6.Stream<List<_i5.AdEntity?>>.empty(),
      ) as _i6.Stream<List<_i5.AdEntity?>>);

  @override
  void removeCurrentAccount() => super.noSuchMethod(
        Invocation.method(
          #removeCurrentAccount,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> setCurrentAccountByEmail(String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCurrentAccountByEmail,
          [email],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> updateAccount(
    String? phoneNumber,
    _i4.SellerType? sellerType,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateAccount,
          [
            phoneNumber,
            sellerType,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  void addFavoriteAd(_i5.AdEntity? ad) => super.noSuchMethod(
        Invocation.method(
          #addFavoriteAd,
          [ad],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeFavoriteAd(_i5.AdEntity? ad) => super.noSuchMethod(
        Invocation.method(
          #removeFavoriteAd,
          [ad],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AccountEntity].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountEntity extends _i1.Mock implements _i4.AccountEntity {
  MockAccountEntity() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get email => (super.noSuchMethod(
        Invocation.getter(#email),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#email),
        ),
      ) as String);

  @override
  String get password => (super.noSuchMethod(
        Invocation.getter(#password),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#password),
        ),
      ) as String);

  @override
  _i4.SellerType get sellerType => (super.noSuchMethod(
        Invocation.getter(#sellerType),
        returnValue: _i4.SellerType.individual,
      ) as _i4.SellerType);

  @override
  String encryptedPassword() => (super.noSuchMethod(
        Invocation.method(
          #encryptedPassword,
          [],
        ),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.method(
            #encryptedPassword,
            [],
          ),
        ),
      ) as String);
}

/// A class which mocks [AdEntity].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdEntity extends _i1.Mock implements _i5.AdEntity {
  MockAdEntity() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get title => (super.noSuchMethod(
        Invocation.getter(#title),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#title),
        ),
      ) as String);

  @override
  _i5.AdCategory get adCategory => (super.noSuchMethod(
        Invocation.getter(#adCategory),
        returnValue: _i5.AdCategory.apartament,
      ) as _i5.AdCategory);

  @override
  List<String> get imagesUrls => (super.noSuchMethod(
        Invocation.getter(#imagesUrls),
        returnValue: <String>[],
      ) as List<String>);

  @override
  String get description => (super.noSuchMethod(
        Invocation.getter(#description),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.getter(#description),
        ),
      ) as String);

  @override
  set property(_i8.PropertyEntity? _property) => super.noSuchMethod(
        Invocation.setter(
          #property,
          _property,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set account(_i4.AccountEntity? _account) => super.noSuchMethod(
        Invocation.setter(
          #account,
          _account,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set landmark(_i9.LandmarkEntity? _landmark) => super.noSuchMethod(
        Invocation.setter(
          #landmark,
          _landmark,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.ListingType get listingType => (super.noSuchMethod(
        Invocation.getter(#listingType),
        returnValue: _i5.ListingType.sale,
      ) as _i5.ListingType);

  @override
  DateTime get dateOfAd => (super.noSuchMethod(
        Invocation.getter(#dateOfAd),
        returnValue: _FakeDateTime_0(
          this,
          Invocation.getter(#dateOfAd),
        ),
      ) as DateTime);

  @override
  _i2.DocumentReferenceEntity get propertyDocument => (super.noSuchMethod(
        Invocation.getter(#propertyDocument),
        returnValue: _FakeDocumentReferenceEntity_1(
          this,
          Invocation.getter(#propertyDocument),
        ),
      ) as _i2.DocumentReferenceEntity);

  @override
  _i2.DocumentReferenceEntity get landmarkDocument => (super.noSuchMethod(
        Invocation.getter(#landmarkDocument),
        returnValue: _FakeDocumentReferenceEntity_1(
          this,
          Invocation.getter(#landmarkDocument),
        ),
      ) as _i2.DocumentReferenceEntity);

  @override
  _i6.Future<void> setReferences() => (super.noSuchMethod(
        Invocation.method(
          #setReferences,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
