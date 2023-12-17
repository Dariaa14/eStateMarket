import 'package:domain/entities/account_entity.dart';

class AccountEntityImpl implements AccountEntity {
  @override
  String email;

  @override
  String password;

  @override
  String? phoneNumber;

  @override
  SellerType sellerType;

  AccountEntityImpl({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.sellerType,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'sellerType': sellerType.index,
    };
  }

  factory AccountEntityImpl.fromJson(Map<String, Object?> json) {
    return AccountEntityImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      sellerType: SellerType.values[json['sellerType'] as int],
    );
  }
}
