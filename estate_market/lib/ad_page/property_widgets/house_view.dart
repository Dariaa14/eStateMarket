import 'package:domain/entities/house_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'residence_view.dart';

class HouseView extends StatelessWidget {
  final HouseEntity property;
  const HouseView({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResidenceView(
          property: property,
        ),
        Text(
          '${AppLocalizations.of(context)!.numberOfFloors}: ${property.numberOfFloors}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.insideSurface}: ${property.insideSurface}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.outsideSurface}: ${property.outsideSurface}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
