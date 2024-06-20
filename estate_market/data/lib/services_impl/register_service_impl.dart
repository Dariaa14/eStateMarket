// ignore_for_file: unused_field

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
  String? _currentEmail;
  Timer? _tokenCheckTimer;

  RegisterServiceImpl() {
    _initializeTokenCheck();
  }

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
  String? getLoggedUserEmail() {
    return _currentEmail;
  }

  @override
  Future<void> saveToken(String token, bool stayConnected) async {
    _currentToken = token;
    await secureStorage.write(key: 'token', value: token);

    Map<String, dynamic> decodedToken = JwtDecoder.decode(_currentToken!);
    String email = decodedToken['email'];
    _currentEmail = email;

    if (stayConnected == true) {
      await secureStorage.write(key: 'email', value: email);
    }
  }

  @override
  Future<void> initializeCurrentEmail() async {
    _currentEmail = await secureStorage.read(key: 'email');
  }

  @override
  Future<void> logout() async {
    _currentToken = null;
    _currentEmail = null;
    await secureStorage.delete(key: 'token');
    await secureStorage.delete(key: 'email');
    _tokenCheckTimer?.cancel();
  }

  bool _isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  Future<void> _refreshToken() async {
    final Uri refreshUri = Uri.parse('http://$nodeServer/refresh');
    try {
      final response = await http.post(refreshUri, body: {'email': _currentEmail});

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String newToken = responseData['token'];
        _currentToken = newToken;
        await secureStorage.write(key: 'token', value: newToken);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _initializeTokenCheck() {
    _tokenCheckTimer = Timer.periodic(Duration(minutes: 1), (timer) async {
      if (_currentToken != null && _isTokenExpired(_currentToken!)) {
        await _refreshToken();
      }
    });
  }
}
