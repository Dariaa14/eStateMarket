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

import '../utils/translate_enums.dart';
import 'create_ad_bloc.dart';
import 'widgets/create_ad_textfield.dart';

//TODO: internationalizare pentru enum-uri

class CreateAdView extends StatelessWidget {
  final CreateAdBloc bloc = CreateAdBloc();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _surfaceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _constructionYearController = TextEditingController();

  CreateAdView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<CreateAdBloc, CreateAdState>(
        bloc: bloc,
        builder: (context, state) {
          return BlocListener<CreateAdBloc, CreateAdState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.insertSuccesful == true) {
                Navigator.pop(context);
              }
            },
            child: SingleChildScrollView(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.adDetails,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20.0),

                    // Write title textbox
                    Text(
                      AppLocalizations.of(context)!.adTitle,
                    ),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.adTitleHintText,
                      controller: _titleController,
                      onChanged: (title) =>
                          bloc.add(SetEmptyFieldsEvent(field: CreateAdFields.title, shouldRemove: title.isNotEmpty)),
                      showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.title),
                    ),
                    const SizedBox(height: 16.0),

                    // Choose property type dropbox
                    Text(AppLocalizations.of(context)!.adCategory),
                    DropdownButton<AdCategory>(
                        value: state.currentCategory,
                        items: [
                          for (final category in AdCategory.values)
                            DropdownMenuItem(value: category, child: Text(adCategoryTranslate(category, context))),
                        ],
                        onChanged: (category) {
                          bloc.add(ChangeCurrentCategoryEvent(category: category));
                        }),
                    const SizedBox(height: 16.0),

                    // Write description textbox
                    Text(AppLocalizations.of(context)!.adDescription),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.adDescriptionHintText,
                      controller: _descriptionController,
                      onChanged: (description) => bloc
                          .add(SetEmptyFieldsEvent(field: CreateAdFields.title, shouldRemove: description.isNotEmpty)),
                      showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.description),
                    ),
                    const SizedBox(height: 16.0),

                    // Listing type radio buttons
                    Text(AppLocalizations.of(context)!.listingType),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final value in ListingType.values)
                          ListTile(
                            title: Text(listingTypeTranslate(value, context)),
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

                    // Properties for all property types:
                    Text(
                      AppLocalizations.of(context)!.propertyDetails,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20.0),

                    // Surface textfield
                    Text(AppLocalizations.of(context)!.surface),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.surfaceHintText,
                      controller: _surfaceController,
                      keyboardType: TextInputType.number,
                      onChanged: (surface) =>
                          bloc.add(SetEmptyFieldsEvent(field: CreateAdFields.title, shouldRemove: surface.isNotEmpty)),
                      showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.surface),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    // Price textfield
                    Text(AppLocalizations.of(context)!.price),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.priceHintText,
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      onChanged: (price) =>
                          bloc.add(SetEmptyFieldsEvent(field: CreateAdFields.price, shouldRemove: price.isNotEmpty)),
                      showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.price),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    // Is negotiable radio button
                    const Text('Is negotiable*'),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.negotiable),
                          leading: Radio<bool>(
                            value: true,
                            groupValue: state.isNegotiable,
                            onChanged: (isNegotiable) {
                              bloc.add(ChangeIsNegotiableEvent(isNegotiable: isNegotiable));
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.nonNegotiable),
                          leading: Radio<bool>(
                            value: false,
                            groupValue: state.isNegotiable,
                            onChanged: (isNegotiable) {
                              bloc.add(ChangeIsNegotiableEvent(isNegotiable: isNegotiable));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    // Construction year textfield
                    Text(AppLocalizations.of(context)!.constructionYear),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.constructionYearHintText,
                      keyboardType: TextInputType.number,
                      controller: _constructionYearController,
                    ),
                    const SizedBox(height: 16.0),

                    // Specific properties based on category:
                    _buildPropertyTypeWidgets(bloc),
                    const SizedBox(height: 16.0),

                    // Submit button
                    PlatformElevatedButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        bloc.add(InsertInDatabaseEvent(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            surface: _surfaceController.text,
                            price: _priceController.text,
                            constructionYear: _constructionYearController.text));

                        _titleController.clear();
                        _descriptionController.clear();
                        _surfaceController.clear();
                        _priceController.clear();
                        _constructionYearController.clear();
                      },
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
      ),
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
