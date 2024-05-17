import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:core/config.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../config/route_names.dart';
import 'main_page_bloc.dart';

class AdItem extends StatelessWidget {
  final AdEntity ad;
  final bool canUserModifyAdd;

  const AdItem({super.key, required this.ad, this.canUserModifyAdd = false});

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainPageBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(RouteNames.adPage, arguments: ad);
        },
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (ad.imagesUrls.isNotEmpty)
              SizedBox(
                height: 190,
                width: MediaQuery.of(context).size.width - 16,
                child: PageView.builder(
                    itemCount: ad.imagesUrls.length,
                    pageSnapping: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 190,
                        width: MediaQuery.of(context).size.width - 16,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: CldImageWidget(
                            publicId: ad.imagesUrls[index],
                            cloudinary: cloudinary,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    }),
              ),
            if (ad.imagesUrls.isEmpty)
              Container(
                height: 190,
                width: MediaQuery.of(context).size.width - 16,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.noImages,
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            BlocBuilder<MainPageBloc, MainPageState>(
              bloc: mainBloc,
              builder: (context, state) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ad.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("${ad.property!.price}"),
                            Text(
                              ad.landmark!.getAddressString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(DateFormat.yMd(Localizations.localeOf(context).toString()).format(ad.dateOfAd)),
                            Text("${ad.property!.surface}"),
                          ],
                        ),
                      ),
                    ),
                    if (state.isUserLoggedIn && !canUserModifyAdd)
                      IconButton(
                          onPressed: () {
                            mainBloc.add(FavoritesButtonPressedEvent(ad: ad));
                          },
                          icon: mainBloc.isAdFavorite(ad)
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_outline)),
                    if (canUserModifyAdd)
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(RouteNames.createAdPage, arguments: ad);
                          },
                          icon: const Icon(Icons.edit)),
                    if (canUserModifyAdd) IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                  ],
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
