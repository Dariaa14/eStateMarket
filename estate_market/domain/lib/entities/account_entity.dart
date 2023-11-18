enum SellerType { individual, company }

abstract class AccountEntity {
  final String username;
  final String password;
  final String? phoneNumber;
  final SellerType sellerType;

  AccountEntity({required this.username, required this.password, this.phoneNumber, required this.sellerType});
}
