import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:estate_market/create_ad_page/property_widgets/residence_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/translate_enums.dart';
import '../create_ad_bloc.dart';
import '../widgets/create_ad_textfield.dart';

class ApartmentWidgets extends StatelessWidget {
  final TextEditingController floorNumberController;
  final TextEditingController numberOfRoomsController;
  final TextEditingController numberOfBathroomsController;
  final AdEntity? ad;
  ApartmentWidgets(
      {super.key,
      required this.ad,
      required this.floorNumberController,
      required this.numberOfRoomsController,
      required this.numberOfBathroomsController}) {
    if (ad != null && ad!.property is ApartmentEntity) {
      floorNumberController.text = (ad!.property! as ApartmentEntity).floor.toString();
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

              // Partitioning dropbox
              Text('${AppLocalizations.of(context)!.partitioningLevel}*'),
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
              Text("${AppLocalizations.of(context)!.floorNumber}*"),
              CreateAdTextfield(
                controller: floorNumberController,
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
