import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/repositories/map_repository.dart';
import 'package:estate_market/map_page/map_page_bloc.dart';
import 'package:estate_market/utils/translate_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RangePanel extends StatelessWidget {
  final MapPageBloc mapBloc;
  final LandmarkEntity landmark;
  const RangePanel({super.key, required this.mapBloc, required this.landmark});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(10.0),
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          BlocBuilder<MapPageBloc, MapPageState>(
            bloc: mapBloc,
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${AppLocalizations.of(context)!.transportMode}:'),
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
              );
            },
          ),
          BlocBuilder<MapPageBloc, MapPageState>(
            bloc: mapBloc,
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text('${state.range ~/ 60} min'),
                      Slider(
                          value: state.range,
                          min: 60,
                          max: 3600,
                          divisions: 60,
                          onChanged: (value) {
                            mapBloc.add(SetRangeValueEvent(range: value));
                          }),
                    ],
                  )),
                  IconButton(
                      onPressed: () {
                        mapBloc.add(ShowRouteRangeEvent(landmark: landmark));
                      },
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
