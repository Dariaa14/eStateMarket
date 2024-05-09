part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final List<AdEntity> ads;
  final bool favoritesChanged;
  final bool isUserLoggedIn;

  const MainPageState({required this.ads, this.favoritesChanged = false, this.isUserLoggedIn = false});

  MainPageState copyWith({List<AdEntity>? ads, bool? favoritesChanged, bool? isUserLoggedIn}) => MainPageState(
        ads: ads ?? this.ads,
        favoritesChanged: favoritesChanged ?? this.favoritesChanged,
        isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
      );

  @override
  List<Object?> get props => [ads, favoritesChanged, isUserLoggedIn];
}
