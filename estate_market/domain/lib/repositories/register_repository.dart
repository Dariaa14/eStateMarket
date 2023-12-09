enum PasswordStrength { none, poor, average, good }

abstract class RegisterRepository {
  PasswordStrength calculatePasswordStrenght(String password);

  Future<bool> createAccount(String email, String password);
  Future<bool> signIn(String email, String password);
}
