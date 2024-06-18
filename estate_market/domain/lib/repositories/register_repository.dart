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
  Future<Either<Failure, bool>> isEmailValid(String email);
  Either<Failure, bool> isPasswordValid(String password);
}
