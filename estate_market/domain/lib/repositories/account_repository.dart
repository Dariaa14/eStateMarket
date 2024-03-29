import 'package:domain/entities/account_entity.dart';

import '../entities/wrappers/document_reference_entity.dart';

abstract class AccountRepository {
  AccountEntity? currentAccount;

  Future<void> setCurrentAccountByEmail(String email);
  Future<void> updateAccount(String? phoneNumber, SellerType? sellerType);

  Future<DocumentReferenceEntity?> getCurrentUserDocumentReference();
}
