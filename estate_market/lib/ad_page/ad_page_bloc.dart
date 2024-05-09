import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:equatable/equatable.dart';

part 'ad_page_event.dart';
part 'ad_page_state.dart';

class AdPageBloc extends Bloc<AdPageEvent, AdPageState> {
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();

  AdPageBloc() : super(const AdPageState()) {
    on<FavoritesButtonPressedEvent>(_favoritesButtonPressedEventHandler);
  }

  _favoritesButtonPressedEventHandler(FavoritesButtonPressedEvent event, Emitter<AdPageState> emit) async {
    emit(state.copyWith(favoritesChanged: !state.favoritesChanged));
  }

  bool isAdFavorite(AdEntity ad) {
    if (_accountUseCase.favoriteAds == null) return false;
    for (final favouriteAd in _accountUseCase.favoriteAds!) {
      if (favouriteAd.dateOfAd.compareTo(ad.dateOfAd) == 0) return true;
    }
    return false;
  }
}
