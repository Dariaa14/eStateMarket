import 'package:estate_market/config/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main_page/main_page_bloc.dart';
import '../map_page/map_page_view.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/icon/icon_with_title.png'),
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              title: Text(AppLocalizations.of(context)!.explore),
              onTap: () {
                final arguments = {'type': MapType.seeProperties};
                Navigator.pushNamed(context, RouteNames.mapPage, arguments: arguments);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(AppLocalizations.of(context)!.favorites),
              onTap: () {
                final mainBloc = BlocProvider.of<MainPageBloc>(context);
                if (mainBloc.state.isUserLoggedIn) {
                  Navigator.pushNamed(context, RouteNames.favoritesPage);
                } else {
                  Navigator.pushNamed(context, RouteNames.registerPage);
                }
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.add),
              title: Text(AppLocalizations.of(context)!.addAdd),
              onTap: () async {
                final mainBloc = BlocProvider.of<MainPageBloc>(context);
                if (mainBloc.state.isUserLoggedIn) {
                  Navigator.pushNamed(context, RouteNames.createAdPage);
                } else {
                  Navigator.pushNamed(context, RouteNames.registerPage);
                }
              },
            ),
            Expanded(child: Container()),
            const Divider(
              thickness: 3,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(AppLocalizations.of(context)!.profile),
              onTap: () {
                final mainBloc = BlocProvider.of<MainPageBloc>(context);
                if (mainBloc.state.isUserLoggedIn) {
                  Navigator.pushNamed(context, RouteNames.profilePage);
                } else {
                  Navigator.pushNamed(context, RouteNames.registerPage);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
