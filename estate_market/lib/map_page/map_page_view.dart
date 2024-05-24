import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_kit/d3Scene.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'map_page_bloc.dart';

class MapPageView extends StatelessWidget {
  final LandmarkEntity? landmark;
  const MapPageView({super.key, this.landmark});

  Future<void> onMapCreated(MapPageBloc mapBloc, GemMapController controller) async {
    diWithMapController(controller);

    if (landmark == null) {
      mapBloc.add(InitAddressSelectionEvent());
      return;
    }
    mapBloc.add(InitViewLandmarkEvent(landmark: landmark!));
  }

  @override
  Widget build(BuildContext context) {
    final MapPageBloc mapBloc = MapPageBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text((landmark == null) ? AppLocalizations.of(context)!.selectAddress : ''),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          if (landmark == null)
            TextButton(
              onPressed: () => Navigator.pop(context, mapBloc.state.landmark),
              child: Text(AppLocalizations.of(context)!.save),
            ),
        ],
      ),
      body: BlocBuilder<MapPageBloc, MapPageState>(
        bloc: mapBloc,
        builder: (context, state) {
          return Stack(
            children: [
              GemMap(
                onMapCreated: (controller) => onMapCreated(mapBloc, controller),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: (state.hasLocationPermission) ? Theme.of(context).colorScheme.primary : Colors.red,
                      shape: BoxShape.circle),
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => _onLocationButtonPressed(mapBloc, context),
                    child: (state.hasLocationPermission)
                        ? Icon(Icons.location_on, color: Theme.of(context).colorScheme.onPrimary, size: 40)
                        : Icon(Icons.location_off, color: Theme.of(context).colorScheme.onPrimary, size: 40),
                  ),
                ),
              ),
              if (landmark != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => mapBloc.add(CenterOnLandmarkEvent(landmark: landmark!)),
                      child: Icon(Icons.center_focus_strong_rounded,
                          color: Theme.of(context).colorScheme.onPrimary, size: 40),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.landmark!.getAddressString(),
                        ),
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: IconButton(
                            iconSize: 20,
                            onPressed: () => mapBloc.add(DeactivateLandmarkHightlightEvent()),
                            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  _onLocationButtonPressed(MapPageBloc mapBloc, BuildContext context) {
    {
      final mapState = mapBloc.state;
      if (!mapState.hasLocationPermission) {
        mapBloc.add(RequestLocationPermissionEvent());
        return;
      } else if (!mapState.isLocationEnabled) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.locationDisabled)));
        return;
      }
      mapBloc.add(FollowPositionEvent());
    }
  }
}
