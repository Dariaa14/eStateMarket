import 'package:domain/entities/ad_entity.dart';
import 'package:estate_market/main_page/category_item.dart';
import 'package:estate_market/main_page/property_item.dart';
import 'package:estate_market/widgets/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sidebar_menu/sidebar_menu_view.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomTextField(
            hintText: "Search",
            prefix: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          actions: [
            IconButton(
                onPressed: () {},
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
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const Text("Categories"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AdCategory.values.length,
                          itemBuilder: (context, index) {
                            return CategoryItem(category: AdCategory.values[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return const ListTile(
                        title: PropertyItem(),
                      );
                    },
                    childCount: 100,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
