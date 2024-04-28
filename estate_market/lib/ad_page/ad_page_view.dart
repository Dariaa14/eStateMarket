import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:core/config.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/house_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:estate_market/ad_page/ad_page_bloc.dart';
import 'package:estate_market/ad_page/property_widgets/apartment_view.dart';
import 'package:estate_market/ad_page/property_widgets/deposit_view.dart';
import 'package:estate_market/ad_page/property_widgets/garage_view.dart';
import 'package:estate_market/ad_page/property_widgets/house_view.dart';
import 'package:estate_market/config/route_names.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'property_widgets/terrain_view.dart';

//TODO: Implement adding to favorites from here
class AdPageView extends StatelessWidget {
  final AdPageBloc bloc = AdPageBloc();
  final AdEntity ad;
  AdPageView({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        automaticallyImplyLeading: true,
        trailingActions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (ad.imagesUrls.isNotEmpty)
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                      itemCount: ad.imagesUrls.length,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 190,
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: CldImageWidget(
                            publicId: ad.imagesUrls[index],
                            cloudinary: cloudinary,
                            fit: BoxFit.fitWidth,
                          ),
                        );
                      }),
                ),
              if (ad.imagesUrls.isEmpty)
                SizedBox(
                  height: 250,
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy').format(ad.dateOfAd),
                            softWrap: true,
                            style: const TextStyle(fontSize: 10),
                          ),
                          Text(
                            ad.title,
                            softWrap: true,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.price}: ${ad.property!.price.toString()} (${(ad.property!.isNegotiable) ? AppLocalizations.of(context)!.negotiable : AppLocalizations.of(context)!.nonNegotiable})',
                            softWrap: true,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.listingType}: ${listingTypeTranslate(ad.listingType, context)}',
                            softWrap: true,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 20,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${AppLocalizations.of(context)!.adDescription}: ',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(
                              ad.description,
                              softWrap: true,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 20,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.propertyDetails,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(
                              '${AppLocalizations.of(context)!.surface}: ${ad.property!.surface.toString()}',
                              softWrap: true,
                              style: const TextStyle(fontSize: 16),
                            ),
                            if (ad.property!.constructionYear != null)
                              Text(
                                '${AppLocalizations.of(context)!.constructionYear}: ${ad.property!.constructionYear.toString()}',
                                softWrap: true,
                                style: const TextStyle(fontSize: 16),
                              ),
                            buildPropertyTypeWidgets(),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.aboutSeller,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          if (ad.account!.phoneNumber != '')
                            Text(
                              '${AppLocalizations.of(context)!.phoneNumber}${ad.account!.phoneNumber}',
                              softWrap: true,
                              style: const TextStyle(fontSize: 16),
                            ),
                          Text(
                            '${AppLocalizations.of(context)!.typeOfSeller}${sellerTypeTranslate(ad.account!.sellerType, context)}',
                            softWrap: true,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    if (ad.landmark != null)
                      Container(
                        height: 45,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.mapPage,
                              arguments: ad.landmark!,
                            );
                          },
                          child: Center(
                            child:
                                Text(AppLocalizations.of(context)!.seeLocation, style: const TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.contactSeller),
            ),
          ),
        ),
      ]),
    );
  }

  buildPropertyTypeWidgets() {
    switch (ad.adCategory) {
      case AdCategory.apartament:
        return ApartmentView(property: ad.property as ApartmentEntity);
      case AdCategory.deposit:
        return DepositView(
          property: ad.property as DepositEntity,
        );
      case AdCategory.garage:
        return GarageView(
          property: ad.property as GarageEntity,
        );
      case AdCategory.house:
        return HouseView(
          property: ad.property as HouseEntity,
        );
      case AdCategory.terrain:
        return TerrainView(
          property: ad.property as TerrainEntity,
        );
      default:
        return Container();
    }
  }
}
