import 'dart:async';

import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/errors/failure.dart';
import 'package:domain/errors/register_errors.dart';
import 'package:domain/repositories/register_repository.dart';

import 'package:dartz/dartz.dart';

import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  @override
  PasswordStrength calculatePasswordStrenght(String password) {
    if (password.isEmpty) {
      return PasswordStrength.none;
    }

    int length = password.length;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int lengthThreshold = 8;

    int strength = 0;
    if (length >= lengthThreshold) strength++;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasNumber) strength++;
    if (hasSpecialChar) strength++;

    if (strength <= 1) {
      return PasswordStrength.veryWeak;
    } else if (strength <= 2) {
      return PasswordStrength.weak;
    } else if (strength <= 3) {
      return PasswordStrength.moderate;
    } else if (strength <= 4) {
      return PasswordStrength.strong;
    } else {
      return PasswordStrength.veryStrong;
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailValid(String email) async {
    if (email.isEmpty) {
      return Left(MissingEmail());
    }
    final RegExp emailRegex = RegExp(r'^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');
    if (!emailRegex.hasMatch(email)) {
      return Left(InvalidEmail());
    }
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    final result = await accounts.where('email', WhereOperations.isEqualTo, email).get();
    if (result.isNotEmpty) {
      return Left(EmailAlreadyInUse());
    }

    return Right(true);
  }

  @override
  Either<Failure, bool> isPasswordValid(String password) {
    if (password.isEmpty) {
      return Left(MissingPassword());
    }
    if (password.length < 8) {
      return Left(PasswordTooShort());
    }
    if (calculatePasswordStrenght(password).index < PasswordStrength.moderate.index) {
      return Left(PasswordTooWeak());
    }

    return Right(true);
  }
}
