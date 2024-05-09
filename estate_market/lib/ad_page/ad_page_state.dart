part of 'ad_page_bloc.dart';

class AdPageState extends Equatable {
  final bool favoritesChanged;
  const AdPageState({this.favoritesChanged = false});

  AdPageState copyWith({bool? favoritesChanged}) {
    return AdPageState(favoritesChanged: favoritesChanged ?? this.favoritesChanged);
  }

  @override
  List<Object> get props => [favoritesChanged];
}
