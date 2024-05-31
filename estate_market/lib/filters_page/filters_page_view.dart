import 'package:dartz/dartz.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main_page/main_page_bloc.dart';
import '../utils/translate_enums.dart';
import '../widgets/custom_textfield.dart';

class FiltersPageView extends StatelessWidget {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final TextEditingController _minSurfaceController = TextEditingController();
  final TextEditingController _maxSurfaceController = TextEditingController();

  FiltersPageView({super.key});

  _initTextfields(MainPageBloc mainBloc) {
    _minPriceController.text = mainBloc.state.priceRange.head?.toString() ?? '';
    _maxPriceController.text = mainBloc.state.priceRange.tail?.toString() ?? '';
    _minSurfaceController.text = mainBloc.state.surfaceRange.head?.toString() ?? '';
    _maxSurfaceController.text = mainBloc.state.surfaceRange.tail?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final MainPageBloc mainBloc = BlocProvider.of<MainPageBloc>(context);
    _initTextfields(mainBloc);

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
              // Category
              Text('${AppLocalizations.of(context)!.adCategory}:'),
              BlocBuilder<MainPageBloc, MainPageState>(
                bloc: mainBloc,
                builder: (context, state) {
                  return DropdownButton<AdCategory?>(
                      value: state.currentCategory,
                      items: [
                        DropdownMenuItem(value: null, child: Text(AppLocalizations.of(context)!.any)),
                        for (final category in AdCategory.values)
                          DropdownMenuItem(value: category, child: Text(adCategoryTranslate(category, context))),
                      ],
                      onChanged: (category) {
                        mainBloc.add(ChangeCurrentCategoryEvent(category: category));
                      });
                },
              ),
              const SizedBox(height: 16.0),

              // Listing type
              Text('${AppLocalizations.of(context)!.listingType}:'),

              BlocBuilder<MainPageBloc, MainPageState>(
                bloc: mainBloc,
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.any),
                        leading: Radio<ListingType?>(
                          value: null,
                          groupValue: state.currentListingType,
                          onChanged: (listingType) {
                            mainBloc.add(ChangeCurrentListingTypeEvent(listingType: listingType));
                          },
                        ),
                      ),
                      for (final value in ListingType.values)
                        ListTile(
                          title: Text(listingTypeTranslate(value, context)),
                          leading: Radio<ListingType?>(
                            value: value,
                            groupValue: state.currentListingType,
                            onChanged: (listingType) {
                              mainBloc.add(ChangeCurrentListingTypeEvent(listingType: listingType));
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16.0),

              // Price
              Text('${AppLocalizations.of(context)!.price}:'),
              BlocBuilder<MainPageBloc, MainPageState>(
                bloc: mainBloc,
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                          child: CustomTextfield(
                        controller: _minPriceController,
                        hintText: AppLocalizations.of(context)!.from,
                        keyboardType: TextInputType.number,
                        onChanged: (minPrice) {
                          mainBloc.add(ChangePriceRangeEvent(
                            priceRange: Tuple2(
                              double.tryParse(minPrice),
                              state.priceRange.tail,
                            ),
                          ));
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomTextfield(
                        controller: _maxPriceController,
                        hintText: AppLocalizations.of(context)!.to,
                        keyboardType: TextInputType.number,
                        onChanged: (maxPrice) {
                          mainBloc.add(ChangePriceRangeEvent(
                            priceRange: Tuple2(
                              state.priceRange.head,
                              double.tryParse(maxPrice),
                            ),
                          ));
                        },
                      ))
                    ],
                  );
                },
              ),
              const SizedBox(height: 16.0),

              // Surface
              Text('${AppLocalizations.of(context)!.surface}:'),
              BlocBuilder<MainPageBloc, MainPageState>(
                bloc: mainBloc,
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                          child: CustomTextfield(
                        controller: _minSurfaceController,
                        hintText: AppLocalizations.of(context)!.from,
                        keyboardType: TextInputType.number,
                        onChanged: (minSurface) {
                          mainBloc.add(ChangeSurfaceRangeEvent(
                            surfaceRange: Tuple2(
                              double.tryParse(minSurface),
                              state.surfaceRange.tail,
                            ),
                          ));
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomTextfield(
                        controller: _maxSurfaceController,
                        hintText: AppLocalizations.of(context)!.to,
                        keyboardType: TextInputType.number,
                        onChanged: (maxSurface) {
                          mainBloc.add(ChangeSurfaceRangeEvent(
                            surfaceRange: Tuple2(
                              state.surfaceRange.head,
                              double.tryParse(maxSurface),
                            ),
                          ));
                        },
                      ))
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
