import 'package:domain/entities/ad_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main_page/main_page_bloc.dart';
import '../utils/translate_enums.dart';
import '../widgets/custom_textfield.dart';

class FiltersPageView extends StatelessWidget {
  const FiltersPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainPageBloc mainBloc = BlocProvider.of<MainPageBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppLocalizations.of(context)!.adCategory}:'),
              BlocBuilder<MainPageBloc, MainPageState>(
                bloc: mainBloc,
                builder: (context, state) {
                  return DropdownButton<AdCategory?>(
                      value: state.currentCategory,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('Any category')),
                        for (final category in AdCategory.values)
                          DropdownMenuItem(value: category, child: Text(adCategoryTranslate(category, context))),
                      ],
                      onChanged: (category) {
                        mainBloc.add(ChangeCurrentCategoryEvent(category: category));
                      });
                },
              ),
              const SizedBox(height: 16.0),
              Text('${AppLocalizations.of(context)!.price}:'),
              Row(
                children: [
                  Expanded(
                      child: CustomTextfield(
                    hintText: 'From',
                    keyboardType: TextInputType.number,
                    onChanged: (minPrice) {},
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextfield(
                    hintText: 'To',
                    keyboardType: TextInputType.number,
                    onChanged: (maxPrice) {},
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
