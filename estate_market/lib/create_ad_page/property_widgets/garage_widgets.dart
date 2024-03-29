import 'package:domain/entities/garage_entity.dart';
import 'package:estate_market/create_ad_page/create_ad_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/translate_enums.dart';
import '../widgets/create_ad_textfield.dart';

class GarageWidgets extends StatelessWidget {
  final CreateAdBloc bloc;
  const GarageWidgets({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
      bloc: bloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parking type dropbox
            Text(AppLocalizations.of(context)!.parkingType),
            DropdownButton<ParkingType>(
              value: state.parkingType,
              items: [
                for (final type in ParkingType.values)
                  DropdownMenuItem(value: type, child: Text(parkingTypesTranslate(type, context))),
              ],
              onChanged: (type) {
                bloc.add(ChangeParkingTypeEvent(parkingType: type));
              },
            ),
            const SizedBox(height: 16.0),

            // Set capacity
            Text(AppLocalizations.of(context)!.capacityOfGarage),
            CreateAdTextfield(
              hintText: AppLocalizations.of(context)!.capacityOfGarageHintText,
              keyboardType: TextInputType.number,
              onChanged: (value) => bloc.add(ChangeParkingCapacityEvent(parkingCapacity: value)),
              showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.garageCapacity),
            ),
          ],
        );
      },
    );
  }
}
