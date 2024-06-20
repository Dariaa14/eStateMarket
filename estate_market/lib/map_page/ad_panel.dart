import 'package:domain/entities/ad_entity.dart';
import 'package:estate_market/config/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/translate_enums.dart';
import 'map_page_bloc.dart';

class AdPanel extends StatelessWidget {
  final AdEntity ad;
  final MapPageBloc mapBloc;
  const AdPanel({super.key, required this.ad, required this.mapBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 140,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 30,
              height: 30,
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurfaceVariant),
                onPressed: () {
                  mapBloc.add(SelectedAdUpdateEvent(ad: null));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0, right: 38.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  ad.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${AppLocalizations.of(context)!.adCategory}: ${adCategoryTranslate(ad.adCategory, context)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${AppLocalizations.of(context)!.price}: ${ad.property!.price} €, ${AppLocalizations.of(context)!.surface}: ${ad.property!.surface} m²',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.adPage, arguments: {'ad': ad});
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(AppLocalizations.of(context)!.goToAdPage)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
