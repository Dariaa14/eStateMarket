import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/translate_enums.dart';
import '../create_ad_bloc.dart';
import '../../widgets/custom_textfield.dart';

class DepositWidgets extends StatelessWidget {
  final AdEntity? ad;
  final TextEditingController heightController;
  final TextEditingController usableSurfaceController;
  final TextEditingController administrativeSurfaceController;
  final TextEditingController parkingSpacesController;

  DepositWidgets(
      {super.key,
      required this.ad,
      required this.heightController,
      required this.usableSurfaceController,
      required this.administrativeSurfaceController,
      required this.parkingSpacesController}) {
    if (ad != null && ad!.property is DepositEntity) {
      heightController.text = (ad!.property! as DepositEntity).height.toString();
      usableSurfaceController.text = (ad!.property! as DepositEntity).usableSurface.toString();
      administrativeSurfaceController.text = (ad!.property! as DepositEntity).administrativeSurface.toString();
      parkingSpacesController.text = (ad!.property! as DepositEntity).parkingSpaces.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final CreateAdBloc bloc = BlocProvider.of<CreateAdBloc>(context);
    return BlocBuilder<CreateAdBloc, CreateAdState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Height textfield
              Text('${AppLocalizations.of(context)!.height}*'),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      controller: heightController,
                      hintText: AppLocalizations.of(context)!.heightHintText,
                      keyboardType: TextInputType.number,
                      onChanged: (height) {
                        bloc.add(ChangeHeightEvent(height: height));
                      },
                      showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.height),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Text('m'),
                ],
              ),
              const SizedBox(height: 16),

              // Usable surface textfield
              Text('${AppLocalizations.of(context)!.usableSurface}*'),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      controller: usableSurfaceController,
                      hintText: AppLocalizations.of(context)!.usableSurfaceHintText,
                      keyboardType: TextInputType.number,
                      onChanged: (usableSurface) {
                        bloc.add(ChangeUsableSurfaceEvent(usableSurface: usableSurface));
                      },
                      showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.usableSurface),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Text('m²'),
                ],
              ),
              const SizedBox(height: 16),

              // Administrative surface textfield
              Text('${AppLocalizations.of(context)!.administrativeSurface}*'),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      controller: administrativeSurfaceController,
                      hintText: AppLocalizations.of(context)!.administrativeSurfaceHintText,
                      keyboardType: TextInputType.number,
                      onChanged: (administrativeSurface) {
                        bloc.add(ChangeAdministrativeSurfaceEvent(administrativeSurface: administrativeSurface));
                      },
                      showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.administrativeSurface),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Text('m²'),
                ],
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
              Text('${AppLocalizations.of(context)!.parkingSpaces}*'),
              CustomTextfield(
                controller: parkingSpacesController,
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
