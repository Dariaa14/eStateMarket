import 'package:domain/entities/deposit_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_ad_bloc.dart';

class DepositWidgets extends StatelessWidget {
  final CreateAdBloc bloc;
  const DepositWidgets({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdBloc, CreateAdState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Height textfield
              const Text("Height*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add the height'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Usable surface textfield
              const Text("Usable surface*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add the usable surface'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Administrative surface textfield
              const Text("Administrative surface*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add the administrative surface'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              const Text("Deposit type*"),
              DropdownButton<DepositType>(
                value: state.depositType,
                items: [
                  for (final depositType in DepositType.values)
                    DropdownMenuItem(value: depositType, child: Text(depositType.name)),
                ],
                onChanged: (depositType) {
                  bloc.add(ChangeDepositTypeEvent(depositType: depositType));
                },
              ),
              const SizedBox(height: 16),

              // Parking spaces textfield
              const Text("Parking spaces*"),
              const TextField(
                decoration: InputDecoration(hintText: 'Add the number of parking spaces'),
                keyboardType: TextInputType.number,
              ),
            ],
          );
        });
  }
}
