import 'package:domain/entities/terrain_entity.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TerrainView extends StatelessWidget {
  final TerrainEntity property;
  const TerrainView({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.landUseCategory}: ${landUseCategoriesTranslate(property.landUseCategory, context)}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          (property.isInBuildUpArea)
              ? AppLocalizations.of(context)!.insideBuildUpArea
              : AppLocalizations.of(context)!.outsideBuildUpArea,
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
