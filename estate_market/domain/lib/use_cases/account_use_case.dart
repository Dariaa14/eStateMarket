import 'dart:async';

import 'package:domain/repositories/account_repository.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/account_entity.dart';
import '../entities/ad_entity.dart';

class AccountUseCase {
  final AccountRepository _accountRepository;
  final DatabaseRepository _databaseRepository;

  final _accountController = StreamController<bool>.broadcast();
  final _favoriteAdsController = StreamController<List<AdEntity>>.broadcast();
  final BehaviorSubject<List<AdEntity?>> _myAdsController = BehaviorSubject();

  AccountUseCase({required AccountRepository accountRepository, required DatabaseRepository databaseRepository})
      : _accountRepository = accountRepository,
        _databaseRepository = databaseRepository {
    _accountRepository.accountStream.listen((account) {
      _accountController.add(account != null);
    });
    _accountRepository.favoriteAdsStream.listen((favoriteAds) {
      _favoriteAdsController.add(favoriteAds ?? []);
    });
    _accountRepository.myAdsStream.listen((myAds) {
      _myAdsController.add(myAds);
    });
  }

  Future<void> updateAccount(String? phoneNumber, SellerType? sellerType) {
    return _accountRepository.updateAccount(phoneNumber, sellerType);
  }

  Future<void> addFavoriteAd(AdEntity ad) async {
    if (_accountRepository.currentAccount == null) throw Exception("User is not logged in");

    _accountRepository.addFavoriteAd(ad);
    _databaseRepository.insertFavoriteAd(account: _accountRepository.currentAccount!, ad: ad);
  }

  Future<void> removeFavoriteAd(AdEntity ad) async {
    if (_accountRepository.currentAccount == null) throw Exception("User is not logged in");

    _accountRepository.removeFavoriteAd(ad);
    _databaseRepository.removeFavoriteAd(account: _accountRepository.currentAccount!, ad: ad);
  }

  Stream<bool> get accountStatus => _accountController.stream;
  Stream<List<AdEntity>> get favoriteAdsStream => _favoriteAdsController.stream;
  Stream<List<AdEntity?>> get myAdsStream => _myAdsController.stream;

  AccountEntity? get currentAccount {
    return _accountRepository.currentAccount;
  }

  List<AdEntity>? get favoriteAds {
    return _accountRepository.favoriteAds;
  }

  void dispose() {
    _accountController.close();
    _favoriteAdsController.close();
    _myAdsController.close();
  }

  bool areControllersClosed() {
    return _accountController.isClosed && _favoriteAdsController.isClosed && _myAdsController.isClosed;
  }
}
