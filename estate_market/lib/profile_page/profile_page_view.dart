import 'package:estate_market/config/route_names.dart';
import 'package:estate_market/profile_page/profile_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/profile_list_tile.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageBloc profileBloc = BlocProvider.of<ProfilePageBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ProfileListTile(
            icon: Icons.library_books_outlined,
            title: AppLocalizations.of(context)!.myAds,
            onTap: () {
              Navigator.pushNamed(context, RouteNames.myAdsPage);
            },
          ),
          ProfileListTile(
            icon: Icons.chat_rounded,
            title: AppLocalizations.of(context)!.conversations,
            onTap: () {},
          ),
          ProfileListTile(
            icon: Icons.edit,
            title: AppLocalizations.of(context)!.editProfile,
            onTap: () {
              Navigator.pushNamed(context, RouteNames.editProfilePage);
            },
          ),
          ProfileListTile(
            icon: Icons.logout,
            title: AppLocalizations.of(context)!.logout,
            onTap: () {
              profileBloc.logoutButtonPressed().then(
                    (value) => Navigator.pop(context),
                  );
            },
          ),
        ],
      ),
    );
  }
}
