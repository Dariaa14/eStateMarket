import 'package:estate_market/profile_page/subpages/my_ads_page/my_ads_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main_page/ad_item.dart';

class MyAdsViewPage extends StatelessWidget {
  const MyAdsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myAdsBloc = BlocProvider.of<MyAdsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppLocalizations.of(context)!.myAds),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MyAdsBloc, MyAdsState>(
          bloc: myAdsBloc..add(InitMyAdsPageEvent()),
          builder: (context, state) {
            if (state.ads.isEmpty) {
              return Center(child: Text(AppLocalizations.of(context)!.noFavorites));
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.ads.length,
                itemBuilder: (context, index) {
                  if (state.ads[index] == null) return const SizedBox.shrink();
                  return AdItem(
                    ad: state.ads[index]!,
                    canUserModifyAdd: true,
                  );
                });
          },
        ),
      ),
    );
  }
}
