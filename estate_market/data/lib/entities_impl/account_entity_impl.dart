import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/account_entity.dart';

import '../utils/encrypt.dart';

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
      'password': encryptedPassword(),
      'phoneNumber': phoneNumber,
      'sellerType': sellerType.index,
    };
  }

  factory AccountEntityImpl.fromJson(Map<String, Object?> json) {
    return AccountEntityImpl(
      email: json['email'] as String,
      password: decryptValue(json['password'] as String),
      phoneNumber: json['phoneNumber'] as String,
      sellerType: SellerType.values[json['sellerType'] as int],
    );
  }

  static Future<AccountEntity?> getAccountFromDocument(DocumentReference<Map<String, dynamic>> document) async {
    final account = await document.get();
    return AccountEntityImpl.fromJson(account.data()!);
  }

  @override
  String encryptedPassword() => encryptValue(password);
}
