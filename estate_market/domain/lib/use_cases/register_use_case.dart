import 'package:dartz/dartz.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/services/register_service.dart';

import '../errors/failure.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository _registerRepository;
  final RegisterService _registerService;
  final DatabaseRepository _databaseRepository;

  RegisterUseCase(
      {required RegisterRepository registerRepository,
      required RegisterService registerService,
      required DatabaseRepository databaseRepository})
      : _registerRepository = registerRepository,
        _registerService = registerService,
        _databaseRepository = databaseRepository;

  PasswordStrength calculatePasswordStrenght(String password) {
    return _registerRepository.calculatePasswordStrenght(password);
  }

  Future<Either<Failure, String?>> createAccount(String email, String password) async {
    return await _registerRepository.createAccount(email, password);
  }

  Future<Either<Failure, String?>> signIn(String email, String password) async {
    return await _registerRepository.signIn(email, password);
  }

  Future<void> addAccount(Map accountData) async {
    final String email = accountData['email'];
    final String password = accountData['password'];

    await _databaseRepository.insertAccountEntity(
        email: email, password: password, phoneNumber: '', sellerType: SellerType.none);
    await _registerService.addAccount(accountData);
  }
}
