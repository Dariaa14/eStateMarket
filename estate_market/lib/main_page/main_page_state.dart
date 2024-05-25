part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final List<AdEntity> ads;
  final bool favoritesChanged;
  final bool isUserLoggedIn;

  final AdCategory? currentCategory;
  final ListingType? currentListingType;

  final Tuple2<double?, double?> priceRange;
  final Tuple2<double?, double?> surfaceRange;

  final String searchQuery;

  const MainPageState(
      {required this.ads,
      this.favoritesChanged = false,
      this.isUserLoggedIn = false,
      this.currentCategory,
      this.currentListingType,
      this.priceRange = const Tuple2(null, null),
      this.surfaceRange = const Tuple2(null, null),
      this.searchQuery = ''});

  MainPageState copyWith(
          {List<AdEntity>? ads,
          bool? favoritesChanged,
          bool? isUserLoggedIn,
          AdCategory? currentCategory,
          ListingType? currentListingType,
          Tuple2<double?, double?>? priceRange,
          Tuple2<double?, double?>? surfaceRange,
          String? searchQuery}) =>
      MainPageState(
        ads: ads ?? this.ads,
        favoritesChanged: favoritesChanged ?? this.favoritesChanged,
        isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
        currentCategory: currentCategory ?? this.currentCategory,
        currentListingType: currentListingType ?? this.currentListingType,
        priceRange: priceRange ?? this.priceRange,
        surfaceRange: surfaceRange ?? this.surfaceRange,
        searchQuery: searchQuery ?? this.searchQuery,
      );

  MainPageState copyWithNullCategory() => MainPageState(
        ads: ads,
        favoritesChanged: favoritesChanged,
        isUserLoggedIn: isUserLoggedIn,
        priceRange: priceRange,
        surfaceRange: surfaceRange,
        currentListingType: currentListingType,
        currentCategory: null,
        searchQuery: searchQuery,
      );

  MainPageState copyWithNullListingType() => MainPageState(
        ads: ads,
        favoritesChanged: favoritesChanged,
        isUserLoggedIn: isUserLoggedIn,
        priceRange: priceRange,
        surfaceRange: surfaceRange,
        currentListingType: null,
        currentCategory: currentCategory,
        searchQuery: searchQuery,
      );

  @override
  List<Object?> get props => [
        ads,
        favoritesChanged,
        isUserLoggedIn,
        currentCategory,
        currentListingType,
        priceRange,
        surfaceRange,
        searchQuery
      ];
}
