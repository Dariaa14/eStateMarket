import 'dart:async';

import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/errors/failure.dart';
import 'package:domain/errors/register_errors.dart';
import 'package:domain/repositories/register_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
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

  // @override
  // Future<Either<Failure, String?>> createAccount(String email, String password) async {
  //   Completer<Either<Failure, String?>> completer = Completer<Either<Failure, String?>>();
  //   try {
  //     final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final String? token = await user.user!.getIdToken();
  //     completer.complete(Right(token));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       completer.complete(Left(PasswordTooWeak()));
  //     } else if (e.code == 'email-already-in-use') {
  //       completer.complete(Left(EmailAlreadyInUse()));
  //     } else if (e.code == 'missing-password') {
  //       completer.complete(Left(MissingPassword()));
  //     } else if (e.code == 'invalid-email') {
  //       completer.complete(Left(InvalidEmail()));
  //     } else if (e.code == 'missing-email') {
  //       completer.complete(Left(MissingEmail()));
  //     } else if (e.code == 'network-request-failed') {
  //       completer.complete(Left(NetworkRequestFailed()));
  //     } else {
  //       print('REGISTER ERROR: $e');
  //       completer.complete(Left(UnknownError()));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return completer.future;
  // }

  // @override
  // Future<Either<Failure, String?>> signIn(String email, String password) async {
  //   Completer<Either<Failure, String?>> completer = Completer<Either<Failure, String?>>();
  //   try {
  //     final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  //     final String? token = await user.user!.getIdToken();
  //     completer.complete(Right(token));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'missing-password') {
  //       completer.complete(Left(MissingPassword()));
  //     } else if (e.code == 'invalid-email') {
  //       completer.complete(Left(InvalidEmail()));
  //     } else if (e.code == 'missing-email') {
  //       completer.complete(Left(MissingEmail()));
  //     } else if (e.code == 'network-request-failed') {
  //       completer.complete(Left(NetworkRequestFailed()));
  //     } else if (e.code == 'invalid-credential') {
  //       completer.complete(Left(InvalidCredential()));
  //     } else if (e.code == 'missing-password') {
  //       completer.complete(Left(MissingPassword()));
  //     } else {
  //       print('REGISTER ERROR: $e');
  //       completer.complete(Left(UnknownError()));
  //     }
  //   }
  //   return completer.future;
  // }

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
