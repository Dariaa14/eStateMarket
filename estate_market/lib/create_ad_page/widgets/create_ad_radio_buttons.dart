import 'package:flutter/material.dart';

class CreateAdRadioButtons extends StatelessWidget {
  final List items;
  const CreateAdRadioButtons({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final item in items)
          Container(
            width: (MediaQuery.of(context).size.width - 36) / items.length,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.horizontal(
                left: item == items.first ? const Radius.circular(8.0) : Radius.zero,
                right: item == items.last ? const Radius.circular(8.0) : Radius.zero,
              ),
            ),
            child: Center(
              child: Text(
                (item as Enum).name,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          )
      ],
    );
  }
}
