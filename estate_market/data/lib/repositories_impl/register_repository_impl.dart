import 'package:domain/repositories/register_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
    int complexityThreshold = 3;

    int strength = 0;
    if (length >= lengthThreshold) strength++;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasNumber) strength++;
    if (hasSpecialChar) strength++;

    if (strength < complexityThreshold) {
      return PasswordStrength.poor;
    } else if (strength < complexityThreshold + 2) {
      return PasswordStrength.average;
    } else {
      return PasswordStrength.good;
    }
  }

  @override
  Future<bool> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }
}
