import 'package:domain/entities/apartment_entity.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'residence_view.dart';

class ApartmentView extends StatelessWidget {
  final ApartmentEntity property;
  const ApartmentView({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResidenceView(
          property: property,
        ),
        Text(
          '${AppLocalizations.of(context)!.partitioningLevel}: ${partitioningTranslate(property.partitioning, context)}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.floorNumber}: ${property.floor}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
