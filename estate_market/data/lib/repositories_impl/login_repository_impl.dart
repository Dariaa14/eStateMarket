import 'package:dartz/dartz.dart';
import 'package:data/utils/encrypt.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/errors/failure.dart';
import 'package:domain/errors/register_errors.dart';
import 'package:domain/repositories/login_repository.dart';

import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<Failure, AccountEntity>> login(String email, String password) async {
    if (email.isEmpty) {
      return Left(MissingEmail());
    }
    if (password.isEmpty) {
      return Left(MissingPassword());
    }

    CollectionReferenceEntity accounts = CollectionReferenceEntityImpl(collection: Collections.accounts);
    final result = await accounts
        .where("email", WhereOperations.isEqualTo, email)
        .where("password", WhereOperations.isEqualTo, encryptValue(password))
        .get();
    if (result.isEmpty) {
      return Left(InvalidCredential());
    }

    print('Account was found');
    final account = result[0] as AccountEntity;
    return Right(account);
  }
}
