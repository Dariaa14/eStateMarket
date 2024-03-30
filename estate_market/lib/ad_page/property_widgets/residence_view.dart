import 'package:domain/entities/residence_entity.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResidenceView extends StatelessWidget {
  final ResidenceEntity property;
  const ResidenceView({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.numberOfRooms}: ${property.numberOfRooms}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.numberOfBathrooms}: ${property.numberOfBathrooms}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.furnishingLevel}: ${furnishingLevelTranslate(property.furnishingLevel, context)}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
