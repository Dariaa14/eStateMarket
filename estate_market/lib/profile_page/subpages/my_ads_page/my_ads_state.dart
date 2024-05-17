part of 'my_ads_bloc.dart';

class MyAdsState extends Equatable {
  final List<AdEntity?> ads;

  const MyAdsState({required this.ads});

  MyAdsState copyWith({List<AdEntity?>? ads}) => MyAdsState(
        ads: ads ?? this.ads,
      );

  @override
  List<Object> get props => [ads];
}
