import 'package:dartz/dartz.dart';
import 'package:data/utils/encrypt.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/errors/failure.dart';
import 'package:domain/repositories/login_repository.dart';
import 'package:domain/errors/login_errors.dart';

import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<Failure, AccountEntity>> login(String email, String password) async {
    CollectionReferenceEntity accounts = CollectionReferenceEntityImpl(collection: Collections.accounts);
    final result = await accounts
        .where("email", WhereOperations.isEqualTo, email)
        .where("password", WhereOperations.isEqualTo, encryptValue(password))
        .get();
    if (result.isEmpty) {
      print('Account was NOT found');
      return Left(AccountNotFound());
    }

    print('Account was found');
    final account = result[0] as AccountEntity;
    return Right(account);
  }
}
