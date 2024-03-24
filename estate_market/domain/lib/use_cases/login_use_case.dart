import 'package:dartz/dartz.dart';
import 'package:domain/errors/register_errors.dart';
import 'package:domain/repositories/login_repository.dart';
import 'package:domain/services/register_service.dart';

import '../errors/failure.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;
  final RegisterService _registerService;

  LoginUseCase({required LoginRepository loginRepository, required RegisterService registerService})
      : _loginRepository = loginRepository,
        _registerService = registerService;

  Future<Either<Failure, String>> login(String email, String password, bool stayConnected) async {
    final account = await _loginRepository.login(email, password);
    if (account.isLeft()) {
      return Left((account as Left).value);
    }
    final token = await _registerService.login(email, password);
    if (token == null) {
      return Left(NetworkRequestFailed());
    }
    await _registerService.saveToken(token, stayConnected);
    return Right(token);
  }

  Future<void> logout() async {
    await _registerService.logout();
  }

  bool isUserLoggedIn() {
    return _registerService.getCurrentUserEmail() != null;
  }

  Future<void> initializeCurrentToken() async {
    await _registerService.initializeCurrentToken();
  }
}
