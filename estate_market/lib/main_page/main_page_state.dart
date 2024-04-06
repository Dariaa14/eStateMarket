part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final List<AdEntity> ads;
  final bool favoritesChanged;

  const MainPageState({required this.ads, this.favoritesChanged = false});

  MainPageState copyWith({List<AdEntity>? ads, bool? favoritesChanged}) => MainPageState(
        ads: ads ?? this.ads,
        favoritesChanged: favoritesChanged ?? this.favoritesChanged,
      );

  @override
  List<Object?> get props => [ads, favoritesChanged];
}
