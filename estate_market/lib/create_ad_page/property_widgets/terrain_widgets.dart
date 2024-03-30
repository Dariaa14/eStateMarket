import 'package:domain/entities/terrain_entity.dart';
import 'package:estate_market/create_ad_page/create_ad_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/translate_enums.dart';

class TerrainWidget extends StatelessWidget {
  final CreateAdBloc bloc;
  const TerrainWidget({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
      bloc: bloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Land use categories dropbox
            Text('${AppLocalizations.of(context)!.landUseCategory}*'),
            DropdownButton<LandUseCategories>(
                value: state.landUseCategory,
                items: [
                  for (final category in LandUseCategories.values)
                    DropdownMenuItem(value: category, child: Text(landUseCategoriesTranslate(category, context))),
                ],
                onChanged: (category) {
                  bloc.add(ChangeLandUseCategoryEvent(landUseCategory: category));
                }),
            const SizedBox(height: 16.0),

            // Is in build-up area radio button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.insideBuildUpArea),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: state.isInBuildUpArea,
                    onChanged: (isInBuildUpArea) {
                      bloc.add(ChangeBuildUpStatusEvent(buildUpStatus: isInBuildUpArea));
                    },
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.outsideBuildUpArea),
                  leading: Radio<bool>(
                    value: false,
                    groupValue: state.isInBuildUpArea,
                    onChanged: (isInBuildUpArea) {
                      bloc.add(ChangeBuildUpStatusEvent(buildUpStatus: isInBuildUpArea));
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
