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
  final TextEditingController _insideSurfaceController = TextEditingController();
  final TextEditingController _outsideSurfaceController = TextEditingController();
  final TextEditingController _numberOfFloorsController = TextEditingController();
  HouseWidgets({super.key, required this.ad}) {
    if (ad != null && ad!.property is HouseEntity) {
      _insideSurfaceController.text = (ad!.property! as HouseEntity).insideSurface.toString();
      _outsideSurfaceController.text = (ad!.property! as HouseEntity).outsideSurface.toString();
      _numberOfFloorsController.text = (ad!.property! as HouseEntity).numberOfFloors.toString();
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
              ResidenceWidgets(ad: ad),

              // Inside surface textfield
              Text('${AppLocalizations.of(context)!.insideSurface}*'),
              CreateAdTextfield(
                controller: _insideSurfaceController,
                hintText: AppLocalizations.of(context)!.insideSurfaceHintText,
                keyboardType: TextInputType.number,
                onChanged: (text) => bloc.add(ChangeInsideSurfaceEvent(insideSurface: text)),
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.insideSurface),
              ),
              const SizedBox(height: 16),

              // Outside surface textfield
              Text('${AppLocalizations.of(context)!.outsideSurface}*'),
              CreateAdTextfield(
                controller: _outsideSurfaceController,
                hintText: AppLocalizations.of(context)!.outsideSurfaceHintText,
                keyboardType: TextInputType.number,
                onChanged: (text) => bloc.add(ChangeOutsideSurfaceEvent(outsideSurface: text)),
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.outsideSurface),
              ),
              const SizedBox(height: 16),

              // Floors number textfield
              Text('${AppLocalizations.of(context)!.numberOfFloors}*'),
              CreateAdTextfield(
                controller: _numberOfFloorsController,
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
