import 'package:domain/entities/garage_entity.dart';
import 'package:estate_market/create_ad_page/create_ad_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            const Text("Parking type*"),
            DropdownButton<ParkingType>(
              value: state.parkingType,
              items: [
                for (final type in ParkingType.values) DropdownMenuItem(value: type, child: Text(type.name)),
              ],
              onChanged: (type) {
                bloc.add(ChangeParkingTypeEvent(parkingType: type));
              },
            ),
            const SizedBox(height: 16.0),

            // Set capacity
            const TextField(
              decoration: InputDecoration(hintText: 'Add capacity of garage'),
              keyboardType: TextInputType.number,
            ),
          ],
        );
      },
    );
  }
}
