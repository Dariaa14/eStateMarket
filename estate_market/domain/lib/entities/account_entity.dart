enum SellerType { individual, company }

abstract class AccountEntity {
  final String email;
  final String password;
  final String? phoneNumber;
  final SellerType sellerType;

  AccountEntity({required this.email, required this.password, this.phoneNumber, required this.sellerType});
}
