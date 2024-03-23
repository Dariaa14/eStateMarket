import 'dart:convert';

import 'package:domain/services/register_service.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class RegisterServiceImpl implements RegisterService {
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
}
