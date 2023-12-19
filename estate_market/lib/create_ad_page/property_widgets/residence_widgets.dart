import 'package:domain/entities/residence_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_ad_bloc.dart';

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
          const Text("Number of rooms*"),
          const TextField(
            decoration: InputDecoration(hintText: 'Add number of rooms'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          // Number of bathrooms text field
          const Text("Number of bathrooms*"),
          const TextField(
            decoration: InputDecoration(hintText: 'Add number of bathrooms'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          // Furnishing level dropbox
          const Text("Furnishing level*"),
          DropdownButton<FurnishingLevel>(
            value: state.furnishingLevel,
            items: [
              for (final level in FurnishingLevel.values) DropdownMenuItem(value: level, child: Text(level.name)),
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
