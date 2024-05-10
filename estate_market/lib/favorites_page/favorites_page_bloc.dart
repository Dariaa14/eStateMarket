import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:equatable/equatable.dart';

part 'favorites_page_event.dart';
part 'favorites_page_state.dart';

class FavoritesPageBloc extends Bloc<FavoritesPageEvent, FavoritesPageState> {
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();
  late StreamSubscription<List<AdEntity>> _favoritesSubscription;

  FavoritesPageBloc() : super(const FavoritesPageState(ads: [])) {
    on<InitFavoritesPageEvent>(_initFavoritesPageEventHandler);

    on<SetFavoritesEvent>(_setFavoritesEventHandler);
  }

  _initFavoritesPageEventHandler(InitFavoritesPageEvent event, Emitter<FavoritesPageState> emit) {
    add(SetFavoritesEvent(ads: _accountUseCase.favoriteAds ?? []));
    _favoritesSubscription = _accountUseCase.favoriteAdsStream.listen((List<AdEntity> ads) {
      add(SetFavoritesEvent(ads: ads));
    });
  }

  _setFavoritesEventHandler(SetFavoritesEvent event, Emitter<FavoritesPageState> emit) =>
      emit(state.copyWith(ads: event.ads));

  @override
  Future<void> close() {
    _favoritesSubscription.cancel();
    return super.close();
  }
}
