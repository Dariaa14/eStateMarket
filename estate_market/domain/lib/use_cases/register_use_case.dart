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

  Future<Either<Failure, bool>> addAccount(String email, String password) async {
    final isEmailValid = await _registerRepository.isEmailValid(email);
    final isPasswordValid = _registerRepository.isPasswordValid(password);
    if (isEmailValid.isLeft()) {
      return Left((isEmailValid as Left).value);
    }
    if (isPasswordValid.isLeft()) {
      return Left((isPasswordValid as Left).value);
    }

    await _databaseRepository.insertAccountEntity(
        email: email, password: password, phoneNumber: '', sellerType: SellerType.none);
    await _registerService.login(email, password);

    return Right(true);
  }
}
