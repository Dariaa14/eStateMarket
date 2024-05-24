part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final List<AdEntity> ads;
  final bool favoritesChanged;
  final bool isUserLoggedIn;

  final AdCategory? currentCategory;
  final double? minPrice;
  final double? maxPrice;

  const MainPageState(
      {required this.ads,
      this.favoritesChanged = false,
      this.isUserLoggedIn = false,
      this.currentCategory,
      this.minPrice,
      this.maxPrice});

  MainPageState copyWith(
          {List<AdEntity>? ads,
          bool? favoritesChanged,
          bool? isUserLoggedIn,
          AdCategory? currentCategory,
          double? minPrice,
          double? maxPrice}) =>
      MainPageState(
        ads: ads ?? this.ads,
        favoritesChanged: favoritesChanged ?? this.favoritesChanged,
        isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
        currentCategory: currentCategory ?? this.currentCategory,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
      );

  MainPageState copyWithNullCategory() => MainPageState(
        ads: ads,
        favoritesChanged: favoritesChanged,
        isUserLoggedIn: isUserLoggedIn,
        minPrice: minPrice,
        maxPrice: maxPrice,
        currentCategory: null,
      );

  @override
  List<Object?> get props => [ads, favoritesChanged, isUserLoggedIn, currentCategory, minPrice, maxPrice];
}
