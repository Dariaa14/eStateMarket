import 'dart:async';
import 'dart:convert';

import 'package:domain/services/register_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../config.dart';

class RegisterServiceImpl implements RegisterService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? _currentToken;

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
  String? getUserEmailFromToken() {
    if (_currentToken == null) return null;
    Map<String, dynamic> decodedToken = JwtDecoder.decode(_currentToken!);

    String email = decodedToken['email'];

    print('Email: $email');
    return email;
  }

  @override
  Future<void> saveToken(String token, bool stayConnected) async {
    _currentToken = token;
    if (stayConnected == true) {
      await secureStorage.write(key: 'token', value: token);
    }
  }

  @override
  Future<void> initializeCurrentToken() async {
    String? token = await secureStorage.read(key: 'token');
    _currentToken = token;
  }

  @override
  Future<void> logout() async {
    _currentToken = null;
    await secureStorage.delete(key: 'token');
  }
}
