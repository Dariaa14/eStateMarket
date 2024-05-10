import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/favorites_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';

import 'account_entity_impl.dart';
import 'ad_enitity_impl.dart';
import 'wrappers/document_reference_entity_impl.dart';

class FavoritesEntityImpl implements FavoritesEntity {
  DocumentReferenceEntity _accountReference;
  DocumentReferenceEntity _adReference;

  @override
  AccountEntity? account;

  @override
  AdEntity? ad;

  FavoritesEntityImpl(
      {required DocumentReferenceEntity? accountReference, required DocumentReferenceEntity? adReference})
      : _accountReference = accountReference!,
        _adReference = adReference!;

  Map<String, dynamic> toJson() {
    return {
      'account': (_accountReference as DocumentReferenceEntityImpl).ref,
      'ad': (_adReference as DocumentReferenceEntityImpl).ref,
    };
  }

  factory FavoritesEntityImpl.fromJson(Map<String, Object?> json) {
    return FavoritesEntityImpl(
      accountReference: DocumentReferenceEntityImpl(ref: json['account'] as DocumentReference<Map<String, dynamic>>),
      adReference: DocumentReferenceEntityImpl(ref: json['ad'] as DocumentReference<Map<String, dynamic>>),
    );
  }

  @override
  Future<void> setReferences() async {
    AccountEntity? account = await AccountEntityImpl.getAccountFromDocument(
        (_accountReference as DocumentReferenceEntityImpl).ref as DocumentReference<Map<String, dynamic>>);
    this.account = account;

    AdEntity? ad = await AdEntityImpl.getAdFromDocument(_adReference);
    this.ad = ad;
  }
}
