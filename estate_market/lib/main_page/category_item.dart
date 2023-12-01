import 'package:domain/entities/ad_entity.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final AdCategory category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        Text(category.name),
      ],
    );
  }
}
