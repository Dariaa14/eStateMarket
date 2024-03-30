import 'package:domain/entities/garage_entity.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GarageView extends StatelessWidget {
  final GarageEntity property;
  const GarageView({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.parkingType}: ${parkingTypesTranslate(property.parkingType, context)}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.capacityOfGarage}: ${property.capacity}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
