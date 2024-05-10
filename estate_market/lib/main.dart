import 'package:core/config.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:estate_market/ad_page/ad_page_bloc.dart';
import 'package:estate_market/config/route_names.dart';
import 'package:estate_market/config/themes.dart';
import 'package:estate_market/create_ad_page/create_ad_bloc.dart';
import 'package:estate_market/favorites_page/favorites_page_bloc.dart';
import 'package:estate_market/main_page/main_page_bloc.dart';
import 'package:estate_market/main_page/main_page_view.dart';
import 'package:estate_market/map_page/map_page_bloc.dart';
import 'package:estate_market/profile_page/profile_page_bloc.dart';
import 'package:estate_market/register_page/register_page_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gem_kit/core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  diRepositories();
  diUseCases();

  GemKitPlatform.instance.loadNative().then((value) {
    SdkSettings.setAppAuthorization(gemKitToken);
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainPageBloc()),
        BlocProvider(create: (context) => AdPageBloc()),
        BlocProvider(create: (context) => RegisterPageBloc()),
        BlocProvider(create: (context) => ProfilePageBloc()),
        BlocProvider(create: (context) => CreateAdBloc()),
        BlocProvider(create: (context) => MapPageBloc()),
        BlocProvider(create: (context) => FavoritesPageBloc()),
      ],
      child: MaterialApp(
        title: 'eState Market',
        theme: lightThemeData,
        darkTheme: darkThemeData,
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
        onGenerateRoute: onGenerateRoute,
        home: const SafeArea(child: MainPageView()),
      ),
    );
  }
}
