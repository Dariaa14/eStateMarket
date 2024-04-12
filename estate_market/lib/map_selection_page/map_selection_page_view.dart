import 'package:flutter/material.dart';
import 'package:gem_kit/d3Scene.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapSelectionPageView extends StatelessWidget {
  const MapSelectionPageView({super.key});

  Future<void> onMapCreated(GemMapController controller) async {
    // mapController = controller;
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
            onMapCreated: onMapCreated,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
              margin: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Icon(Icons.location_on, color: Theme.of(context).colorScheme.onPrimary, size: 40),
              ),
            ),
          )
        ],
      ),
    );
  }
}
