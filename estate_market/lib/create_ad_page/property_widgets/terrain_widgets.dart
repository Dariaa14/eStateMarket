import 'package:domain/entities/terrain_entity.dart';
import 'package:estate_market/create_ad_page/create_ad_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            const Text("Land use categories*"),
            DropdownButton<LandUseCategories>(
                value: state.landUseCategory,
                items: [
                  for (final category in LandUseCategories.values)
                    DropdownMenuItem(value: category, child: Text(category.name)),
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
                  title: const Text('Inside build-up area'),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: state.isInBuildUpArea,
                    onChanged: (isInBuildUpArea) {
                      bloc.add(ChangeBuildUpStatusEvent(buildUpStatus: isInBuildUpArea));
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Outside build-up area'),
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
