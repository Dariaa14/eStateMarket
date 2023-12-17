import 'package:domain/entities/ad_entity.dart';
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
                  Text(AppLocalizations.of(context)!.adTitle),
                  TextField(
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.adTitleHintText),
                  ),
                  const SizedBox(height: 16.0),
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
                  Text(AppLocalizations.of(context)!.adDescription),
                  TextField(
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.adDescriptionHintText),
                  ),
                  const SizedBox(height: 20.0),
                  PlatformElevatedButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.postAd,
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
