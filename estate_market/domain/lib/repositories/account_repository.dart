import 'package:domain/entities/account_entity.dart';

import '../entities/ad_entity.dart';
import '../entities/wrappers/document_reference_entity.dart';

abstract class AccountRepository {
  AccountEntity? currentAccount;
  DocumentReferenceEntity? currentAccountDocument;
  List<AdEntity>? favoriteAds;

  void removeCurrentAccount();
  Future<void> setCurrentAccountByEmail(String email);
  Future<void> updateAccount(String? phoneNumber, SellerType? sellerType);

  Future<List<AdEntity>> getAccountsAds();

  void addFavoriteAd(AdEntity ad);
  void removeFavoriteAd(AdEntity ad);

  Stream<AccountEntity?> get accountStream;
}
