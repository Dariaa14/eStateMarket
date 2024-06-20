import 'package:domain/entities/deposit_entity.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepositView extends StatelessWidget {
  final DepositEntity property;
  const DepositView({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.height}: ${property.height} m',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.usableSurface}: ${property.usableSurface} m²',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.administrativeSurface}: ${property.administrativeSurface} m²',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.depositType}: ${depositTypesTranslate(property.depositType, context)}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${AppLocalizations.of(context)!.parkingSpaces}: ${property.parkingSpaces}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
