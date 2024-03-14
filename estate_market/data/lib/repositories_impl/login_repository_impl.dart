import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:data/entities_impl/account_entity_impl.dart';
import 'package:data/utils/encrypt.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/errors/failure.dart';
import 'package:domain/repositories/login_repository.dart';
import 'package:domain/errors/login_errors.dart';

class LoginRepositoryImpl implements LoginRepository {
  final accountsRef = FirebaseFirestore.instance.collection('accounts').withConverter<AccountEntity>(
        fromFirestore: (snapshots, _) => AccountEntityImpl.fromJson(snapshots.data()!),
        toFirestore: (ad, _) => (ad as AccountEntityImpl).toJson(),
      );

  @override
  Future<Either<Failure, AccountEntity>> login(String email, String password) async {
    final result =
        await accountsRef.where("email", isEqualTo: email).where("password", isEqualTo: encryptValue(password)).get();
    if (result.docs.isEmpty) {
      print('Account was NOT found');
      return Left(AccountNotFound());
    }

    print('Account was found');
    final accounts = result.docs[0].data();
    return Right(accounts);
  }
}
