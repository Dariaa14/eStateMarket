import '../errors/failure.dart';
import 'package:dartz/dartz.dart';

enum PasswordStrength {
  none,
  veryWeak,
  weak,
  moderate,
  strong,
  veryStrong,
}

abstract class RegisterRepository {
  PasswordStrength calculatePasswordStrenght(String password);

  Future<Either<Failure, String?>> createAccount(String email, String password);
  Future<Either<Failure, String?>> signIn(String email, String password);
}
