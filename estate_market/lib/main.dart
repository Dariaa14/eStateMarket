import 'package:estate_market/config/themes.dart';
import 'package:estate_market/login_page/login_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightThemeData,
      home: SafeArea(child: LoginPage()),
    );
  }
}
