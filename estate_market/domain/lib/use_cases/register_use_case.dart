import '../repositories/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository _registerRepository;

  RegisterUseCase({required RegisterRepository registerRepository}) : _registerRepository = registerRepository;

  PasswordStrength calculatePasswordStrenght(String password) {
    return _registerRepository.calculatePasswordStrenght(password);
  }

  Future<bool> createAccount(String email, String password) async {
    return await _registerRepository.createAccount(email, password);
  }

  Future<bool> signIn(String email, String password) async {
    return await _registerRepository.signIn(email, password);
  }
}
