import 'package:domain/entities/apartment_entity.dart';
import 'package:estate_market/create_ad_page/property_widgets/residence_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_ad_bloc.dart';

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
              const Text("Partitioning level*"),
              DropdownButton<Partitioning>(
                value: state.partitioning,
                items: [
                  for (final partitioning in Partitioning.values)
                    DropdownMenuItem(value: partitioning, child: Text(partitioning.name)),
                ],
                onChanged: (partitioning) {
                  bloc.add(ChangePartitioningEvent(partitioning: partitioning));
                },
              ),
              const SizedBox(height: 16),

              // Floor number textfield
              const Text("Floor*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add floor number'),
                keyboardType: TextInputType.number,
              ),
            ],
          );
        });
  }
}
