import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:estate_market/map_page/map_page_bloc.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoutePanel extends StatelessWidget {
  final MapPageBloc mapBloc;
  final LandmarkEntity landmark;
  const RoutePanel({super.key, required this.mapBloc, required this.landmark});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(10.0),
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<MapPageBloc, MapPageState>(
        bloc: mapBloc,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('${AppLocalizations.of(context)!.transportMode}:'),
                  const SizedBox(width: 10),
                  DropdownButton<TransportMode>(
                      value: state.transportMode,
                      items: [
                        for (final transport in TransportMode.values)
                          DropdownMenuItem(value: transport, child: Text(transportModeTranslate(transport, context))),
                      ],
                      onChanged: (mode) {
                        mapBloc.add(SetTransportModeEvent(mode: mode!));
                      }),
                ],
              ),
              IconButton(
                  onPressed: () {
                    mapBloc.add(ShowRouteRangeEvent(landmark: landmark));
                  },
                  icon: Icon(
                    Icons.route,
                    color: Theme.of(context).colorScheme.onSurface,
                  )),
            ],
          );
        },
      ),
    );
  }
}
