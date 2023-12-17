import 'package:dartz/dartz.dart';

import '../errors/failure.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository _registerRepository;

  RegisterUseCase({required RegisterRepository registerRepository}) : _registerRepository = registerRepository;

  PasswordStrength calculatePasswordStrenght(String password) {
    return _registerRepository.calculatePasswordStrenght(password);
  }

  Future<Either<Failure, String?>> createAccount(String email, String password) async {
    return await _registerRepository.createAccount(email, password);
  }

  Future<Either<Failure, String?>> signIn(String email, String password) async {
    return await _registerRepository.signIn(email, password);
  }
}
