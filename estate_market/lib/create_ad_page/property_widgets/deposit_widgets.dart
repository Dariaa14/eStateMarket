import 'package:domain/entities/deposit_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/translate_enums.dart';
import '../create_ad_bloc.dart';
import '../widgets/create_ad_textfield.dart';

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
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.heightHintText,
                keyboardType: TextInputType.number,
                onChanged: (height) {
                  bloc.add(ChangeHeightEvent(height: height));
                },
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.height),
              ),
              const SizedBox(height: 16),

              // Usable surface textfield
              Text(AppLocalizations.of(context)!.usableSurface),
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.usableSurfaceHintText,
                keyboardType: TextInputType.number,
                onChanged: (usableSurface) {
                  bloc.add(ChangeUsableSurfaceEvent(usableSurface: usableSurface));
                },
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.usableSurface),
              ),
              const SizedBox(height: 16),

              // Administrative surface textfield
              Text(AppLocalizations.of(context)!.administrativeSurface),
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.administrativeSurfaceHintText,
                keyboardType: TextInputType.number,
                onChanged: (administrativeSurface) {
                  bloc.add(ChangeAdministrativeSurfaceEvent(administrativeSurface: administrativeSurface));
                },
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.administrativeSurface),
              ),
              const SizedBox(height: 16),

              Text(AppLocalizations.of(context)!.depositType),
              DropdownButton<DepositType>(
                value: state.depositType,
                items: [
                  for (final depositType in DepositType.values)
                    DropdownMenuItem(value: depositType, child: Text(depositTypesTranslate(depositType, context))),
                ],
                onChanged: (depositType) {
                  bloc.add(ChangeDepositTypeEvent(depositType: depositType));
                },
              ),
              const SizedBox(height: 16),

              // Parking spaces textfield
              Text(AppLocalizations.of(context)!.parkingSpaces),
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.parkingSpacesHintText,
                keyboardType: TextInputType.number,
                onChanged: (parkingSpaces) {
                  bloc.add(ChangeParkingSpacesEvent(parkingSpaces: parkingSpaces));
                },
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.parkingSpaces),
              ),
            ],
          );
        });
  }
}
