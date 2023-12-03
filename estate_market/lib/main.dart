import 'package:estate_market/config/route_names.dart';
import 'package:estate_market/config/themes.dart';
import 'package:estate_market/main_page/main_page_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:estate_market/register_page/register_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eState Market',
      theme: lightThemeData,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ro'),
      ],
      onGenerateRoute: (settings) => RouteNames.generateRoute(settings),
      home: SafeArea(child: MainPageView()),
    );
  }
}
