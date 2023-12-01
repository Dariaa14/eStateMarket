import '../repositories/register_repository.dart';

class RegisterUseCase {
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
}
