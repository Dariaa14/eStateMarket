import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        const Text("item"),
      ],
    );
  }
}
