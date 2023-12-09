import 'package:domain/entities/ad_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdItem extends StatelessWidget {
  final AdEntity? ad;
  const AdItem({super.key, this.ad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
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
                        Text(ad!.title),
                        Text((ad!.property == null) ? "Price" : "${ad!.property!.price}"),
                        const Text("Location"),
                        Text(DateFormat.yMd(Localizations.localeOf(context).toString()).format(ad!.dateOfAd)),
                        Text((ad!.property == null) ? "Surface" : "${ad!.property!.surface}"),
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
