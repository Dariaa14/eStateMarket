import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/house_entity.dart';
import 'package:estate_market/create_ad_page/property_widgets/residence_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../create_ad_bloc.dart';
import '../widgets/create_ad_textfield.dart';

class HouseWidgets extends StatelessWidget {
  final AdEntity? ad;
  final TextEditingController insideSurfaceController;
  final TextEditingController outsideSurfaceController;
  final TextEditingController numberOfFloorsController;
  final TextEditingController numberOfRoomsController;
  final TextEditingController numberOfBathroomsController;
  HouseWidgets(
      {super.key,
      required this.ad,
      required this.insideSurfaceController,
      required this.outsideSurfaceController,
      required this.numberOfFloorsController,
      required this.numberOfRoomsController,
      required this.numberOfBathroomsController}) {
    if (ad != null && ad!.property is HouseEntity) {
      insideSurfaceController.text = (ad!.property! as HouseEntity).insideSurface.toString();
      outsideSurfaceController.text = (ad!.property! as HouseEntity).outsideSurface.toString();
      numberOfFloorsController.text = (ad!.property! as HouseEntity).numberOfFloors.toString();
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
              ResidenceWidgets(
                  ad: ad,
                  numberOfRoomsController: numberOfRoomsController,
                  numberOfBathroomsController: numberOfBathroomsController),

              // Inside surface textfield
              Text('${AppLocalizations.of(context)!.insideSurface}*'),
              CreateAdTextfield(
                controller: insideSurfaceController,
                hintText: AppLocalizations.of(context)!.insideSurfaceHintText,
                keyboardType: TextInputType.number,
                onChanged: (text) => bloc.add(ChangeInsideSurfaceEvent(insideSurface: text)),
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.insideSurface),
              ),
              const SizedBox(height: 16),

              // Outside surface textfield
              Text('${AppLocalizations.of(context)!.outsideSurface}*'),
              CreateAdTextfield(
                controller: outsideSurfaceController,
                hintText: AppLocalizations.of(context)!.outsideSurfaceHintText,
                keyboardType: TextInputType.number,
                onChanged: (text) => bloc.add(ChangeOutsideSurfaceEvent(outsideSurface: text)),
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.outsideSurface),
              ),
              const SizedBox(height: 16),

              // Floors number textfield
              Text('${AppLocalizations.of(context)!.numberOfFloors}*'),
              CreateAdTextfield(
                controller: numberOfFloorsController,
                hintText: AppLocalizations.of(context)!.numberOfFloorsHintText,
                keyboardType: TextInputType.number,
                onChanged: (text) => bloc.add(ChangeNumberOfFloorsEvent(numberOfFloors: text)),
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.numberOfFloors),
              ),
            ],
          );
        });
  }
}
