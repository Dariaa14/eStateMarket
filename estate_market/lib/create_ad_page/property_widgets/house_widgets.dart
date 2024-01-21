import 'package:estate_market/create_ad_page/property_widgets/residence_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../create_ad_bloc.dart';
import '../widgets/create_ad_textfield.dart';

class HouseWidgets extends StatelessWidget {
  final CreateAdBloc bloc;
  const HouseWidgets({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResidenceWidgets(bloc: bloc),

              // Inside surface textfield
              Text(AppLocalizations.of(context)!.insideSurface),
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.insideSurfaceHintText,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Outside surface textfield
              Text(AppLocalizations.of(context)!.outsideSurface),
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.outsideSurfaceHintText,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Floors number textfield
              Text(AppLocalizations.of(context)!.numberOfFloors),
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.numberOfFloorsHintText,
                keyboardType: TextInputType.number,
              ),
            ],
          );
        });
  }
}
