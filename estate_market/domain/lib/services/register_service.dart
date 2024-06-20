abstract class RegisterService {
  Future<String?> login(String email, String password);
  Future<void> logout();

  Future<void> saveToken(String token, bool stayConnected);
  Future<void> initializeCurrentEmail();

  String? getLoggedUserEmail();
}
