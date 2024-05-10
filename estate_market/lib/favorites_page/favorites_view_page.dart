import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main_page/ad_item.dart';
import 'favorites_page_bloc.dart';

class FavoritesViewPage extends StatelessWidget {
  const FavoritesViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoritesPageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppLocalizations.of(context)!.favorites),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FavoritesPageBloc, FavoritesPageState>(
          bloc: favoritesBloc..add(InitFavoritesPageEvent()),
          builder: (context, state) {
            if (state.ads.isEmpty) {
              return Center(child: Text(AppLocalizations.of(context)!.noFavorites));
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.ads.length,
                itemBuilder: (context, index) {
                  return AdItem(ad: state.ads[index]);
                });
          },
        ),
      ),
    );
  }
}
