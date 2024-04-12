import 'package:core/dependency_injector/di.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_kit/d3Scene.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'address_selection_bloc.dart';

class AddressSelectionPageView extends StatelessWidget {
  final AddressSelectionBloc bloc = AddressSelectionBloc();
  AddressSelectionPageView({super.key});

  Future<void> onMapCreated(GemMapController controller, BuildContext context) async {
    diWithMapController(controller);
    bloc.add(InitAddressSelectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectAddress),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          GemMap(
            onMapCreated: (controller) => onMapCreated(controller, context),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: BlocBuilder<AddressSelectionBloc, AddressSelectionState>(
              bloc: bloc,
              builder: (context, state) {
                return Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: (state.status == LocationPermissionStatus.granted)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.red,
                        shape: BoxShape.circle),
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (state.status == LocationPermissionStatus.granted) {
                          bloc.add(FollowPositionEvent());
                        } else {
                          bloc.add(RequestLocationPermissionEvent());
                        }
                      },
                      child: (state.status == LocationPermissionStatus.granted)
                          ? Icon(Icons.location_on, color: Theme.of(context).colorScheme.onPrimary, size: 40)
                          : Icon(Icons.location_off, color: Theme.of(context).colorScheme.onPrimary, size: 40),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
