import 'package:data/entities_impl/account_entity_impl.dart';
import 'package:data/entities_impl/wrappers/collection_reference_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/repositories/account_repository.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  AccountEntity? currentAccount;

  @override
  Future<void> updateAccount(String? phoneNumber, SellerType? sellerType) async {
    final AccountEntity newAccountData = AccountEntityImpl(
        email: currentAccount!.email,
        phoneNumber: phoneNumber,
        sellerType: sellerType ?? currentAccount!.sellerType,
        password: currentAccount!.password);

    CollectionReferenceEntity collection =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    final currentAccountDoc =
        await collection.where('email', WhereOperations.isEqualTo, currentAccount!.email).getDocuments<AccountEntity>();
    if (currentAccountDoc.isEmpty) {
      throw Exception('Account not found');
    }
    await currentAccountDoc.first.set((newAccountData as AccountEntityImpl).toJson());
  }

  @override
  Future<void> setCurrentAccountByEmail(String email) async {
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: true);
    final accountsWithGivenEmail = await accounts.where('email', WhereOperations.isEqualTo, email).get<AccountEntity>();
    if (accountsWithGivenEmail.isEmpty) currentAccount = null;
    currentAccount = accountsWithGivenEmail.first;
  }

  @override
  Future<DocumentReferenceEntity?> getCurrentUserDocumentReference() async {
    if (currentAccount == null) return null;
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    final accountsWithGivenEmail =
        await accounts.where('email', WhereOperations.isEqualTo, currentAccount!.email).getDocuments();
    if (accountsWithGivenEmail.isEmpty) return null;
    return accountsWithGivenEmail.first;
  }

  @override
  void removeCurrentAccount() {
    currentAccount = null;
  }
}
