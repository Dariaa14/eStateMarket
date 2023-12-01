import 'package:flutter/material.dart';

class PropertyItem extends StatelessWidget {
  const PropertyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('ad tap');
      },
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
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title"),
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
