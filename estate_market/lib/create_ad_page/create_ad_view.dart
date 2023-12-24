import 'package:domain/entities/ad_entity.dart';
import 'package:estate_market/create_ad_page/property_widgets/apartment_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/deposit_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/garage_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/house_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/terrain_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_ad_bloc.dart';

class CreateAdView extends StatelessWidget {
  final CreateAdBloc bloc = CreateAdBloc();
  CreateAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
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
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.adDetails),
                  const SizedBox(height: 20.0),

                  // Write title textbox
                  Text(AppLocalizations.of(context)!.adTitle),
                  TextField(
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.adTitleHintText),
                  ),
                  const SizedBox(height: 16.0),

                  // Choose property type dropbox
                  Text(AppLocalizations.of(context)!.adCategory),
                  DropdownButton<AdCategory>(
                      value: state.currentCategory,
                      items: [
                        for (final category in AdCategory.values)
                          DropdownMenuItem(value: category, child: Text(category.name)),
                      ],
                      onChanged: (category) {
                        bloc.add(ChangeCurrentCategoryEvent(category: category));
                      }),
                  const SizedBox(height: 16.0),

                  // Write description textbox
                  Text(AppLocalizations.of(context)!.adDescription),
                  TextField(
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.adDescriptionHintText),
                  ),
                  const SizedBox(height: 16.0),

                  // Listing type radio buttons
                  Text(AppLocalizations.of(context)!.listingType),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final value in ListingType.values)
                        ListTile(
                          title: Text(value.name),
                          leading: Radio<ListingType>(
                            value: value,
                            groupValue: state.listingType,
                            onChanged: (listingType) {
                              bloc.add(ChangeListingTypeEvent(listingType: listingType));
                            },
                          ),
                        ),
                    ],
                  ),
                  // Add images

                  const SizedBox(height: 20.0),

                  // Specific properties based on category:
                  _buildPropertyTypeWidgets(bloc),
                  const SizedBox(height: 16.0),

                  // Submit button
                  PlatformElevatedButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.postAd,
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildPropertyTypeWidgets(CreateAdBloc bloc) {
    switch (bloc.state.currentCategory) {
      case AdCategory.apartament:
        return ApartmentWidgets(bloc: bloc);
      case AdCategory.deposit:
        return DepositWidgets(bloc: bloc);
      case AdCategory.garage:
        return GarageWidgets(bloc: bloc);
      case AdCategory.house:
        return HouseWidgets(bloc: bloc);
      case AdCategory.terrain:
        return TerrainWidget(bloc: bloc);
      default:
        return Container();
    }
  }
}
