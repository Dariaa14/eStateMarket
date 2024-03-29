import 'package:domain/repositories/account_repository.dart';

import '../entities/account_entity.dart';

class AccountUseCase {
  final AccountRepository _accountRepository;

  AccountUseCase({required AccountRepository accountRepository}) : _accountRepository = accountRepository;

  bool isUserLoggedIn() {
    return _accountRepository.currentAccount != null;
  }

  Future<void> updateAccount(String? phoneNumber, SellerType? sellerType) {
    return _accountRepository.updateAccount(phoneNumber, sellerType);
  }

  AccountEntity? get currentAccount {
    return _accountRepository.currentAccount;
  }
}
