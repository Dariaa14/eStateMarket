import 'package:estate_market/config/route_names.dart';
import 'package:estate_market/profile_page/profile_page_bloc.dart';
import 'package:flutter/material.dart';

import 'widgets/profile_list_tile.dart';

class ProfilePageView extends StatelessWidget {
  final ProfilePageBloc profileBloc = ProfilePageBloc();
  ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
            title: 'My Ads',
            onTap: () {},
          ),
          ProfileListTile(
            icon: Icons.chat_rounded,
            title: 'Conversations',
            onTap: () {},
          ),
          ProfileListTile(
            icon: Icons.edit,
            title: 'Edit Profile',
            onTap: () {
              Navigator.pushNamed(context, RouteNames.editProfilePage);
            },
          ),
          ProfileListTile(
            icon: Icons.logout,
            title: 'Logout',
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
