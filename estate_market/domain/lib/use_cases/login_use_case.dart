import 'package:dartz/dartz.dart';
import 'package:domain/repositories/login_repository.dart';

import '../entities/account_entity.dart';
import '../errors/failure.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase({required LoginRepository loginRepository}) : _loginRepository = loginRepository;

  Future<Either<Failure, AccountEntity>> login(String email, String password) {
    return _loginRepository.login(email, password);
  }
}
