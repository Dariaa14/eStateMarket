import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:data/entities_impl/account_entity_impl.dart';
import 'package:data/entities_impl/wrappers/collection_reference_entity_impl.dart';
import 'package:data/entities_impl/wrappers/document_reference_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/favorites_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/query_snapshot_entity.dart';
import 'package:domain/repositories/account_repository.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';

import '../entities_impl/ad_enitity_impl.dart';

import 'package:rxdart/rxdart.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  AccountEntity? currentAccount;

  final _accountController = StreamController<AccountEntity?>.broadcast();

  @override
  DocumentReferenceEntity? currentAccountDocument;

  @override
  List<AdEntity>? favoriteAds;

  final _favoritesController = StreamController<List<AdEntity>?>.broadcast();

  @override
  Future<void> updateAccount(String? phoneNumber, SellerType? sellerType) async {
    final AccountEntity newAccountData = AccountEntityImpl(
        email: currentAccount!.email,
        phoneNumber: phoneNumber,
        sellerType: sellerType ?? currentAccount!.sellerType,
        password: currentAccount!.password);

    if (currentAccountDocument == null) {
      throw Exception('Account document not set');
    }
    await currentAccountDocument!.set((newAccountData as AccountEntityImpl).toJson());
  }

  @override
  Future<void> setCurrentAccountByEmail(String email) async {
    CollectionReferenceEntity accounts = CollectionReferenceEntityImpl(collection: Collections.accounts);
    final accountsWithGivenEmail = await accounts.where('email', WhereOperations.isEqualTo, email).get<AccountEntity>();
    if (accountsWithGivenEmail.isEmpty) currentAccount = null;
    currentAccount = accountsWithGivenEmail.first;
    currentAccountDocument = await _getCurrentUserDocumentReference();
    favoriteAds = await _getFavoriteAds();
    _favoritesController.add(favoriteAds);
    _accountController.add(currentAccount);
  }

  @override
  void addFavoriteAd(AdEntity ad) {
    favoriteAds!.add(ad);
    _favoritesController.add(favoriteAds);
  }

  @override
  void removeFavoriteAd(AdEntity ad) {
    for (int index = 0; index < favoriteAds!.length; index++) {
      if (favoriteAds![index].dateOfAd.compareTo(ad.dateOfAd) == 0) {
        favoriteAds!.removeAt(index);
        _favoritesController.add(favoriteAds);
        return;
      }
    }
  }

  @override
  void removeCurrentAccount() {
    currentAccount = null;
    currentAccountDocument = null;
    favoriteAds = null;
    _accountController.add(null);
    _favoritesController.add(null);
  }

  Future<DocumentReferenceEntity?> _getCurrentUserDocumentReference() async {
    if (currentAccount == null) throw Exception('Current account is not set');
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    final accountsWithGivenEmail =
        await accounts.where('email', WhereOperations.isEqualTo, currentAccount!.email).getDocuments();
    if (accountsWithGivenEmail.isEmpty) throw Exception('Account was not found');
    return accountsWithGivenEmail.first;
  }

  Future<List<AdEntity>?> _getFavoriteAds() async {
    if (currentAccountDocument == null) throw Exception('Current account is not set');
    CollectionReferenceEntity favoriteAdsCollection = CollectionReferenceEntityImpl(collection: Collections.favorites);
    final reference = (currentAccountDocument as DocumentReferenceEntityImpl).ref;
    final favorites =
        await favoriteAdsCollection.where('account', WhereOperations.isEqualTo, reference).get<FavoritesEntity>();
    final favoriteAds = (favorites.map((favorite) => favorite.ad!)).toList();
    return favoriteAds;
  }

  @override
  Stream<List<AdEntity?>> get myAdsStream {
    CollectionReferenceEntity adsCollection =
        CollectionReferenceEntityImpl(collection: Collections.ad, withConverter: false);
    return Rx.combineLatest2(accountStream, adsCollection.snapshots(), (account, snapshot) => Tuple2(account, snapshot))
        .asyncMap((tuple) async {
      final AccountEntity? account = tuple.head;
      final QuerySnapshotEntity snapshot = tuple.tail;
      if (account == null) {
        return [];
      }
      List<DocumentReferenceEntity> docRefs = snapshot.transformToDocumentReferenceList();
      List<Future<AdEntity?>> futures = docRefs.map((docRef) => AdEntityImpl.getAdFromDocument(docRef)).toList();
      List<AdEntity?> allAds = await Future.wait(futures);

      return allAds.where((ad) => ad?.account?.email == account.email).toList();
    });
  }

  @override
  Stream<AccountEntity?> get accountStream => _accountController.stream;

  @override
  Stream<List<AdEntity>?> get favoriteAdsStream => _favoritesController.stream;
}
