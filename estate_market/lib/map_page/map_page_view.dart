import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:estate_market/map_page/route_panel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gem_kit/map.dart';

import 'ad_panel.dart';
import 'map_page_bloc.dart';

enum MapType { setAddress, seeAddress, seeProperties }

class MapPageView extends StatelessWidget {
  final MapType type;
  final LandmarkEntity? landmark;
  final MapPageBloc mapBloc = MapPageBloc();
  MapPageView({super.key, this.landmark, required this.type});

  Future<void> onMapCreated(MapPageBloc mapBloc, GemMapController controller) async {
    diWithMapController(controller);

    switch (type) {
      case MapType.setAddress:
        mapBloc.add(InitAddressSelectionEvent());
        break;
      case MapType.seeAddress:
        mapBloc.add(InitViewLandmarkEvent(landmark: landmark!));
        break;
      case MapType.seeProperties:
        mapBloc.add(InitPropertiesEvent());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((type == MapType.setAddress) ? AppLocalizations.of(context)!.selectAddress : ''),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          if (type == MapType.setAddress)
            TextButton(
              onPressed: () => Navigator.pop(context, mapBloc.state.landmark),
              child: Text(AppLocalizations.of(context)!.save),
            ),
        ],
      ),
      body: BlocBuilder<MapPageBloc, MapPageState>(
        bloc: mapBloc,
        builder: (context, state) {
          return BlocListener<MapPageBloc, MapPageState>(
            bloc: mapBloc,
            listenWhen: (previous, current) => previous.wasRouteCalculated != current.wasRouteCalculated,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.somethingWentWrong,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
              ));
            },
            child: Stack(
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
                if (type == MapType.seeAddress)
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
                if (type == MapType.seeAddress)
                  Align(
                      alignment: Alignment.topCenter,
                      child: RoutePanel(
                        mapBloc: mapBloc,
                        landmark: landmark!,
                      )),
                if (state.landmark != null && type == MapType.setAddress)
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
                  ),
                if (state.ad != null && type == MapType.seeProperties)
                  Align(
                    alignment: Alignment.topCenter,
                    child: AdPanel(ad: state.ad!, mapBloc: mapBloc),
                  )
              ],
            ),
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
