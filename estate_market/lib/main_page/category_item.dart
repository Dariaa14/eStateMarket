import 'package:domain/entities/ad_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/translate_enums.dart';
import 'main_page_bloc.dart';

class CategoryItem extends StatelessWidget {
  final AdCategory? category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final mainBloc = BlocProvider.of<MainPageBloc>(context);
        mainBloc.add(ChangeCurrentCategoryEvent(category: category));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            Text(category != null ? adCategoryTranslate(category!, context) : AppLocalizations.of(context)!.any),
          ],
        ),
      ),
    );
  }
}
