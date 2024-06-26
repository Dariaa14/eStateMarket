import 'package:domain/entities/ad_entity.dart';
import 'package:estate_market/config/route_names.dart';
import 'package:estate_market/main_page/category_item.dart';
import 'package:estate_market/main_page/main_page_bloc.dart';
import 'package:estate_market/main_page/ad_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../sidebar_menu/sidebar_menu_view.dart';
import '../widgets/custom_textfield.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainPageBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: CustomTextfield(
            showPrefix: true,
            hintText: AppLocalizations.of(context)!.search,
            prefix: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            onChanged: (text) {
              mainBloc.add(ChangeSearchQueryEvent(searchQuery: text));
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.filtersPage);
                },
                icon: Icon(
                  Icons.filter_alt,
                  color: Theme.of(context).colorScheme.onSurface,
                ))
          ],
        ),
        drawer: const SidebarMenu(),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(AppLocalizations.of(context)!.mainCategories),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AdCategory.values.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) return const CategoryItem(category: null);
                            return CategoryItem(category: AdCategory.values[index - 1]);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<MainPageBloc, MainPageState>(
                    bloc: mainBloc..add(InitMainPageEvent()),
                    builder: (context, state) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.ads.length,
                          itemBuilder: (context, index) {
                            return AdItem(ad: state.ads[index]);
                          });
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
