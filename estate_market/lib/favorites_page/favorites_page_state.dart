part of 'favorites_page_bloc.dart';

class FavoritesPageState extends Equatable {
  final List<AdEntity> ads;

  const FavoritesPageState({required this.ads});

  FavoritesPageState copyWith({List<AdEntity>? ads}) => FavoritesPageState(
        ads: ads ?? this.ads,
      );

  @override
  List<Object> get props => [ads];
}
