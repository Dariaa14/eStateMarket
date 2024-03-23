import 'package:estate_market/config/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main_page/main_page_bloc.dart';

//TODO: Implement BlocProviders
class SidebarMenu extends StatelessWidget {
  const SidebarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/app_logo/logo_with_title.png'),
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              title: Text(AppLocalizations.of(context)!.explore),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(AppLocalizations.of(context)!.favorites),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.add),
              title: Text(AppLocalizations.of(context)!.addAdd),
              onTap: () async {
                final mainPageBloc = MainPageBloc();
                mainPageBloc.isUserLoggedIn().then((value) {
                  if (value) {
                    Navigator.pushNamed(context, RouteNames.createAdPage);
                  } else {
                    print("User is not logged in");
                  }
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_filter),
              title: Text(AppLocalizations.of(context)!.photoEditor),
              onTap: () {},
            ),
            Expanded(child: Container()),
            const Divider(
              thickness: 3,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(AppLocalizations.of(context)!.profile),
              onTap: () {
                Navigator.pushNamed(context, RouteNames.registerPage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(AppLocalizations.of(context)!.settings),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
