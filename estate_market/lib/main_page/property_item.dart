import 'package:domain/entities/ad_entity.dart';
import 'package:flutter/material.dart';

class PropertyItem extends StatelessWidget {
  final AdEntity? ad;
  const PropertyItem({super.key, this.ad});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((ad != null) ? ad!.title : "Test title"),
                      Text("Price"),
                      Text("Location"),
                      Text("Date"),
                      Text("Surface"),
                    ],
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
            ],
          ),
        ]),
      ),
    );
  }
}
