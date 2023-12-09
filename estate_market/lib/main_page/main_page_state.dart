part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  final List<AdEntity> ads;

  const MainPageState({required this.ads});

  MainPageState copyWith(List<AdEntity>? ads) => MainPageState(ads: ads ?? this.ads);

  @override
  List<Object?> get props => [ads];
}
