import 'dart:convert';

import 'package:domain/entities/wrappers/collection_reference_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/services/register_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../config.dart';
import '../entities_impl/wrappers/collection_reference_entity_impl.dart';

class RegisterServiceImpl implements RegisterService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> login(String email, String password) async {
    final Uri loginUri = Uri.parse('http://$nodeServer/login');
    try {
      final response = await http.post(
        loginUri,
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String token = responseData['token'];
        return token;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<String?> getCurrentUserEmail() async {
    String? token = await secureStorage.read(key: 'token');
    if (token == '') return null;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    String email = decodedToken['email'];

    print('Email: $email');
    return email;
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<DocumentReferenceEntity?> getCurrentUserDocumentReference() async {
    final email = await getCurrentUserEmail();
    if (email == null) return null;
    CollectionReferenceEntity accounts =
        CollectionReferenceEntityImpl(collection: Collections.accounts, withConverter: false);
    final accountsWithGivenEmail = await accounts.where('email', WhereOperations.isEqualTo, email).getDocuments();
    if (accountsWithGivenEmail.isEmpty) return null;
    return accountsWithGivenEmail.first;
  }
}
