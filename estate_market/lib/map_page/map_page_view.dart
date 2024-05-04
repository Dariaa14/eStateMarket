import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_kit/d3Scene.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'map_page_bloc.dart';

class MapPageView extends StatelessWidget {
  final LandmarkEntity? landmark;
  final MapPageBloc bloc = MapPageBloc();
  MapPageView({super.key, this.landmark});

  Future<void> onMapCreated(GemMapController controller, BuildContext context) async {
    diWithMapController(controller);

    if (landmark == null) {
      bloc.add(InitAddressSelectionEvent());
      return;
    }
    bloc.add(InitViewLandmarkEvent(landmark: landmark!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((landmark == null) ? AppLocalizations.of(context)!.selectAddress : ''),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          if (landmark == null)
            TextButton(
              onPressed: () => Navigator.pop(context, bloc.state.landmark),
              child: Text(AppLocalizations.of(context)!.save),
            ),
        ],
      ),
      body: BlocBuilder<MapPageBloc, MapPageState>(
        bloc: bloc,
        builder: (context, state) {
          return Stack(
            children: [
              GemMap(
                onMapCreated: (controller) => onMapCreated(controller, context),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
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
                  ),
                ),
              ),
              if (state.landmark != null)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      state.landmark!.getName(),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
