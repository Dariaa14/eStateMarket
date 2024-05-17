import 'dart:io';

import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:estate_market/config/route_names.dart';
import 'package:estate_market/create_ad_page/property_widgets/apartment_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/deposit_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/garage_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/house_widgets.dart';
import 'package:estate_market/create_ad_page/property_widgets/terrain_widgets.dart';
import 'package:estate_market/widgets/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/translate_enums.dart';
import 'create_ad_bloc.dart';
import 'widgets/create_ad_textfield.dart';

class CreateAdView extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _surfaceController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _constructionYearController = TextEditingController();

  final AdEntity? ad;

  CreateAdView({super.key, this.ad}) {
    _initAd();
  }

  _initAd() {
    if (ad == null) return;
    _titleController.text = ad!.title;
    _descriptionController.text = ad!.description;
    _surfaceController.text = ad!.property!.surface.toString();
    _priceController.text = ad!.property!.price.toString();
    _constructionYearController.text =
        ad!.property!.constructionYear == null ? '' : ad!.property!.constructionYear.toString();
  }

  @override
  Widget build(BuildContext context) {
    final CreateAdBloc createAdBloc = BlocProvider.of<CreateAdBloc>(context);
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
        bloc: createAdBloc..add(InitAdEvent(ad: ad)),
        builder: (context, state) {
          int currentPhotoIndex = 0;
          return BlocListener<CreateAdBloc, CreateAdState>(
            bloc: createAdBloc,
            listener: (context, state) {
              if (state.status == CreateAdStatus.finished) {
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
                      '${AppLocalizations.of(context)!.adTitle}*',
                    ),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.adTitleHintText,
                      controller: _titleController,
                      onChanged: (title) => createAdBloc
                          .add(SetEmptyFieldsEvent(field: CreateAdFields.title, shouldRemove: title.isNotEmpty)),
                      showPrefix: state.showErrors && createAdBloc.fieldIsEmpty(CreateAdFields.title),
                    ),
                    const SizedBox(height: 16.0),

                    // Choose property type dropbox
                    Text('${AppLocalizations.of(context)!.adCategory}*'),
                    DropdownButton<AdCategory>(
                        value: state.currentCategory,
                        items: [
                          for (final category in AdCategory.values)
                            DropdownMenuItem(value: category, child: Text(adCategoryTranslate(category, context))),
                        ],
                        onChanged: (category) {
                          createAdBloc.add(ChangeCurrentCategoryEvent(category: category));
                        }),
                    const SizedBox(height: 16.0),

                    // Write description textbox
                    Text('${AppLocalizations.of(context)!.adDescription}*'),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.adDescriptionHintText,
                      controller: _descriptionController,
                      onChanged: (description) => createAdBloc.add(
                          SetEmptyFieldsEvent(field: CreateAdFields.description, shouldRemove: description.isNotEmpty)),
                      showPrefix: state.showErrors && createAdBloc.fieldIsEmpty(CreateAdFields.description),
                    ),
                    const SizedBox(height: 16.0),

                    // Listing type radio buttons
                    Text('${AppLocalizations.of(context)!.listingType}*'),

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
                                createAdBloc.add(ChangeListingTypeEvent(listingType: listingType));
                              },
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Add images
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      height: 230,
                      child: InkWell(
                        onTap: () async {
                          if (state.images.isEmpty) {
                            createAdBloc.add(SetImagesEvent(images: await _pickImageFromGallery()));
                          } else {
                            _showImageModal(context, currentPhotoIndex);
                          }
                        },
                        child: state.images.isNotEmpty
                            ? ImageSlider(
                                images: state.images,
                                onPageChanged: (index) => currentPhotoIndex = index,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.secondary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.addImages,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.maximumPhotoCount,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12.0)),
                    const SizedBox(height: 20.0),

                    // Properties for all property types:
                    Text(
                      AppLocalizations.of(context)!.propertyDetails,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20.0),

                    // Surface textfield
                    Text('${AppLocalizations.of(context)!.surface}*'),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.surfaceHintText,
                      controller: _surfaceController,
                      keyboardType: TextInputType.number,
                      onChanged: (surface) => createAdBloc
                          .add(SetEmptyFieldsEvent(field: CreateAdFields.surface, shouldRemove: surface.isNotEmpty)),
                      showPrefix: state.showErrors && createAdBloc.fieldIsEmpty(CreateAdFields.surface),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    // Price textfield
                    Text('${AppLocalizations.of(context)!.price}*'),
                    CreateAdTextfield(
                      hintText: AppLocalizations.of(context)!.priceHintText,
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      onChanged: (price) => createAdBloc
                          .add(SetEmptyFieldsEvent(field: CreateAdFields.price, shouldRemove: price.isNotEmpty)),
                      showPrefix: state.showErrors && createAdBloc.fieldIsEmpty(CreateAdFields.price),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),

                    // Is negotiable radio button
                    Text('${AppLocalizations.of(context)!.negotiable}*'),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.negotiable),
                          leading: Radio<bool>(
                            value: true,
                            groupValue: state.isNegotiable,
                            onChanged: (isNegotiable) {
                              createAdBloc.add(ChangeIsNegotiableEvent(isNegotiable: isNegotiable));
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.nonNegotiable),
                          leading: Radio<bool>(
                            value: false,
                            groupValue: state.isNegotiable,
                            onChanged: (isNegotiable) {
                              createAdBloc.add(ChangeIsNegotiableEvent(isNegotiable: isNegotiable));
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
                    _buildPropertyTypeWidgets(ad, context),
                    const SizedBox(height: 16.0),

                    // Select location
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Theme.of(context).colorScheme.surfaceVariant),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.mapPage).then((value) {
                            if (value != null) createAdBloc.add(SetLandmarkEvent(landmark: value as LandmarkEntity));
                          });
                        },
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                (state.landmark == null)
                                    ? AppLocalizations.of(context)!.selectAddress
                                    : state.landmark!.getAddressString(),
                              ),
                              if (state.landmark != null)
                                IconButton(
                                    onPressed: () => createAdBloc.add(SetLandmarkEvent(landmark: null)),
                                    icon: Icon(
                                      Icons.close,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state.showErrors && createAdBloc.fieldIsEmpty(CreateAdFields.location))
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                        child: Text(
                          AppLocalizations.of(context)!.requiredField,
                          style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12.0),
                        ),
                      ),
                    const SizedBox(height: 16.0),

                    // Submit button
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: PlatformElevatedButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          if (ad == null) {
                            createAdBloc.add(InsertInDatabaseEvent(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                surface: _surfaceController.text,
                                price: _priceController.text,
                                constructionYear: _constructionYearController.text));
                            return;
                          }
                        },
                        child: (state.status == CreateAdStatus.normal)
                            ? Text(
                                (ad == null)
                                    ? AppLocalizations.of(context)!.postAd
                                    : AppLocalizations.of(context)!.editAd,
                                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary),
                              ),
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

  _buildPropertyTypeWidgets(AdEntity? ad, BuildContext context) {
    switch (BlocProvider.of<CreateAdBloc>(context).state.currentCategory) {
      case AdCategory.apartament:
        return ApartmentWidgets(ad: ad);
      case AdCategory.deposit:
        return DepositWidgets(ad: ad);
      case AdCategory.garage:
        return GarageWidgets(ad: ad);
      case AdCategory.house:
        return HouseWidgets(ad: ad);
      case AdCategory.terrain:
        return TerrainWidget(ad: ad);
      default:
        return Container();
    }
  }

  void _showImageModal(BuildContext context, int initialIndex) {
    final PageController pageController = PageController(initialPage: initialIndex);
    int currentIndex = initialIndex;
    final CreateAdBloc bloc = BlocProvider.of<CreateAdBloc>(context);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: BlocBuilder<CreateAdBloc, CreateAdState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: bloc.state.images.length,
                          pageSnapping: true,
                          onPageChanged: (index) => currentIndex = index,
                          itemBuilder: (context, index) {
                            return Image.file(
                              bloc.state.images[index],
                              fit: BoxFit.contain,
                            );
                          }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            List<File> newImagesFile = await _pickImageFromGallery();
                            bloc.add(AddImagesEvent(images: newImagesFile));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.addPhoto,
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            List<File> newImagesList = List.from(bloc.state.images);
                            newImagesList.removeAt(currentIndex);
                            bloc.add(SetImagesEvent(images: newImagesList));
                            if (newImagesList.isEmpty) {
                              Navigator.pop(context);
                            } else {
                              pageController.jumpToPage(currentIndex - 1);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.deletePhoto,
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<File>> _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMultiImage();
    List<File> images = returnedImage.map((imageData) => File(imageData.path)).toList();
    if (images.length > 8) {
      images = images.sublist(0, 8);
    }
    return images;
  }
}
