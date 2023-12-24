import 'package:domain/entities/deposit_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../create_ad_bloc.dart';

class DepositWidgets extends StatelessWidget {
  final CreateAdBloc bloc;
  const DepositWidgets({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Height textfield
              Text(AppLocalizations.of(context)!.height),
              TextField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.heightHintText),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Usable surface textfield
              Text(AppLocalizations.of(context)!.usableSurface),
              TextField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.usableSurfaceHintText),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Administrative surface textfield
              Text(AppLocalizations.of(context)!.administrativeSurface),
              TextField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.administrativeSurfaceHintText),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              Text(AppLocalizations.of(context)!.depositType),
              DropdownButton<DepositType>(
                value: state.depositType,
                items: [
                  for (final depositType in DepositType.values)
                    DropdownMenuItem(value: depositType, child: Text(depositType.name)),
                ],
                onChanged: (depositType) {
                  bloc.add(ChangeDepositTypeEvent(depositType: depositType));
                },
              ),
              const SizedBox(height: 16),

              // Parking spaces textfield
              Text(AppLocalizations.of(context)!.parkingSpaces),
              TextField(
                decoration: InputDecoration(hintText: AppLocalizations.of(context)!.parkingSpacesHintText),
                keyboardType: TextInputType.number,
              ),
            ],
          );
        });
  }
}
