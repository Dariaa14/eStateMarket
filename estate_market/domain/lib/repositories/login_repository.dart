import 'package:dartz/dartz.dart';
import 'package:domain/entities/account_entity.dart';

import '../errors/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, AccountEntity>> login(String email, String password);
}
