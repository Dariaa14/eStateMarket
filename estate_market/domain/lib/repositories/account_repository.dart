import 'package:domain/entities/account_entity.dart';

import '../entities/wrappers/document_reference_entity.dart';

abstract class AccountRepository {
  AccountEntity? currentAccount;
  DocumentReferenceEntity? currentAccountDocument;

  void removeCurrentAccount();
  Future<void> setCurrentAccountByEmail(String email);
  Future<void> updateAccount(String? phoneNumber, SellerType? sellerType);
}
