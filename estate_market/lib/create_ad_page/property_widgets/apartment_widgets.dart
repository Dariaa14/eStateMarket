import 'package:domain/entities/apartment_entity.dart';
import 'package:estate_market/create_ad_page/property_widgets/residence_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/translate_enums.dart';
import '../create_ad_bloc.dart';
import '../widgets/create_ad_textfield.dart';

class ApartmentWidgets extends StatelessWidget {
  final CreateAdBloc bloc;
  const ApartmentWidgets({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResidenceWidgets(bloc: bloc),

              // Partitioning dropbox
              Text(AppLocalizations.of(context)!.partitioningLevel),
              DropdownButton<Partitioning>(
                value: state.partitioning,
                items: [
                  for (final partitioning in Partitioning.values)
                    DropdownMenuItem(value: partitioning, child: Text(partitioningTranslate(partitioning, context))),
                ],
                onChanged: (partitioning) {
                  bloc.add(ChangePartitioningEvent(partitioning: partitioning));
                },
              ),
              const SizedBox(height: 16),

              // Floor number textfield
              Text(AppLocalizations.of(context)!.floorNumber),
              CreateAdTextfield(
                hintText: AppLocalizations.of(context)!.floorNumberHintText,
                keyboardType: TextInputType.number,
                onChanged: (text) => bloc.add(ChangeFloorEvent(floor: text)),
                showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.floorNumber),
              ),
            ],
          );
        });
  }
}
