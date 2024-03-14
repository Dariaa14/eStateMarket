enum SellerType { individual, company, none }

abstract class AccountEntity {
  final String email;
  final String password;
  final String? phoneNumber;
  final SellerType sellerType;

  AccountEntity({required this.email, required this.password, this.phoneNumber, required this.sellerType});

  String encryptedPassword();
}
