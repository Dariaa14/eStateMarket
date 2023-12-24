import 'package:estate_market/create_ad_page/property_widgets/residence_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_ad_bloc.dart';

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
              const Text("Inside surface*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add the inside surface'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Outside surface textfield
              const Text("Outside surface*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add the outside surface'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Floors number textfield
              const Text("Number of floors*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add the number of floors in the building'),
                keyboardType: TextInputType.number,
              ),
            ],
          );
        });
  }
}
