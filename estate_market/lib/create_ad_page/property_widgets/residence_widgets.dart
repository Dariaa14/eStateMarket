import 'package:domain/entities/residence_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/translate_enums.dart';
import '../create_ad_bloc.dart';
import '../widgets/create_ad_textfield.dart';

class ResidenceWidgets extends StatelessWidget {
  final CreateAdBloc bloc;
  const ResidenceWidgets({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
      bloc: bloc,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Number of rooms text field
          Text('${AppLocalizations.of(context)!.numberOfRooms}*'),
          CreateAdTextfield(
            hintText: AppLocalizations.of(context)!.numberOfRoomsHintText,
            keyboardType: TextInputType.number,
            onChanged: (text) => bloc.add(ChangeNumberOfRoomsEvent(numberOfRooms: text)),
            showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.numberOfRooms),
          ),

          const SizedBox(height: 16),

          // Number of bathrooms text field
          Text('${AppLocalizations.of(context)!.numberOfBathrooms}*'),
          CreateAdTextfield(
            hintText: AppLocalizations.of(context)!.numberOfBathroomsHintText,
            keyboardType: TextInputType.number,
            onChanged: (text) => bloc.add(ChangeNumberOfBathroomsEvent(numberOfBathrooms: text)),
            showPrefix: state.showErrors && bloc.fieldIsEmpty(CreateAdFields.numberOfBathrooms),
          ),
          const SizedBox(height: 16),

          // Furnishing level dropbox
          Text('${AppLocalizations.of(context)!.furnishingLevel}*'),
          DropdownButton<FurnishingLevel>(
            value: state.furnishingLevel,
            items: [
              for (final level in FurnishingLevel.values)
                DropdownMenuItem(value: level, child: Text(furnishingLevelTranslate(level, context))),
            ],
            onChanged: (level) {
              bloc.add(ChangeFurnishingLevelCategoryEvent(furnishingLevel: level));
            },
          ),
          const SizedBox(height: 16),
        ]);
      },
    );
  }
}
