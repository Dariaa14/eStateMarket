import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:estate_market/main_page/category_item.dart';
import 'package:estate_market/main_page/main_page_bloc.dart';
import 'package:estate_market/main_page/ad_item.dart';
import 'package:estate_market/widgets/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../sidebar_menu/sidebar_menu_view.dart';

//TODO: when logout/login change state so favorite button is(not) visible
//TODO: when no internet connection show something
class MainPageView extends StatelessWidget {
  final MainPageBloc bloc = MainPageBloc();
  MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomTextField(
            hintText: AppLocalizations.of(context)!.search,
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
            child: SingleChildScrollView(
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
                          itemCount: AdCategory.values.length,
                          itemBuilder: (context, index) {
                            return CategoryItem(category: AdCategory.values[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TODO: Replace StreamBuilder with something else
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('ad').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text('Loading...');
                        }
                        return BlocBuilder<MainPageBloc, MainPageState>(
                          bloc: bloc..add(InitMainPageEvent()),
                          builder: (context, state) {
                            return FutureBuilder<List<AdEntity>>(
                              future: bloc.getAdsTest(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }
                                if (!snapshot.hasData) {
                                  return const Center(child: CircularProgressIndicator());
                                }

                                final data = snapshot.requireData;
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return AdItem(ad: data[index], mainBloc: bloc);
                                    });
                              },
                            );
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
