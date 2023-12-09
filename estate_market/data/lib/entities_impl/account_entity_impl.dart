import 'package:domain/entities/account_entity.dart';

class AccountEntityImpl extends AccountEntity {
  AccountEntityImpl({
    required String username,
    required String password,
    String? phoneNumber,
    required SellerType sellerType,
  }) : super(
          email: username,
          password: password,
          phoneNumber: phoneNumber,
          sellerType: sellerType,
        );

  Map<String, dynamic> toJson() {
    return {
      'username': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'sellerType': sellerType.index,
    };
  }

  factory AccountEntityImpl.fromJson(Map<String, Object?> json) {
    return AccountEntityImpl(
      username: json['username'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      sellerType: SellerType.values[json['sellerType'] as int],
    );
  }
}
