import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:core/config.dart';
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
            if (ad!.imagesUrls.isNotEmpty)
              SizedBox(
                height: 190,
                width: MediaQuery.of(context).size.width - 16,
                child: PageView.builder(
                    itemCount: ad!.imagesUrls.length,
                    pageSnapping: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 190,
                        width: MediaQuery.of(context).size.width - 16,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: CldImageWidget(
                            publicId: ad!.imagesUrls[index],
                            cloudinary: cloudinary,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    }),
              ),
            if (ad!.imagesUrls.isEmpty)
              Container(
                height: 190,
                width: MediaQuery.of(context).size.width - 16,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: CldImageWidget(
                    publicId: ad!.imagesUrls.isEmpty ? "licenta/z87gl6lpok5lqqs2pmxc" : ad!.imagesUrls[0],
                    cloudinary: cloudinary,
                    fit: BoxFit.fitWidth,
                  ),
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
