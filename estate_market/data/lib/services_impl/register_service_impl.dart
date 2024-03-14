import 'dart:convert';

import 'package:data/entities_impl/account_entity_impl.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/services/register_service.dart';
import 'package:http/http.dart' as http;

class RegisterServiceImpl implements RegisterService {
  @override
  Future<void> addAccount(Map accountData) async {
    // AccountEntity account = AccountEntityImpl(
    //     email: accountData['email'],
    //     password: accountData['password'],
    //     phoneNumber: '',
    //     sellerType: SellerType.company);

    // var url = Uri.parse('http://192.168.1.10:2000/api/register_account');

    // try {
    //   final res = await http.post(url, body: accountData);
    //   if (res.statusCode == 200) {
    //     var decodedData = jsonDecode(res.body.toString());
    //     print(decodedData);
    //   } else {
    //     print('Failed to add account');
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
