import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:domain/use_cases/login_use_case.dart';
import 'package:equatable/equatable.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();
  final LoginUseCase _loginUseCase = sl.get<LoginUseCase>();
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();

  MainPageBloc() : super(const MainPageState(ads: [])) {
    on<InitMainPageEvent>(_initMainPageEventHandler);
    on<FavoritesButtonPressedEvent>(_favoritesButtonPressedEventHandler);

    on<CurrentUserChangedEvent>(_currentUserChangedEventHandler);
  }

  _initMainPageEventHandler(InitMainPageEvent event, Emitter<MainPageState> emit) async {
    await _loginUseCase.initializeCurrentToken();
    _accountUseCase.accountStatus.listen((bool isLoggedIn) {
      add(CurrentUserChangedEvent(isLoggedIn: isLoggedIn));
    });
    // final ads = await _databaseUseCase.getAllAds();
    // emit(state.copyWith(ads: ads));
  }

  _favoritesButtonPressedEventHandler(FavoritesButtonPressedEvent event, Emitter<MainPageState> emit) async {
    if (state.isUserLoggedIn) {
      if (isAdFavorite(event.ad)) {
        _accountUseCase.removeFavoriteAd(event.ad);
      } else {
        _accountUseCase.addFavoriteAd(event.ad);
      }
      emit(state.copyWith(favoritesChanged: !state.favoritesChanged));
    }
  }

  _currentUserChangedEventHandler(CurrentUserChangedEvent event, Emitter<MainPageState> emit) =>
      emit(state.copyWith(isUserLoggedIn: event.isLoggedIn));

  Future<List<AdEntity>> getAdsTest() async {
    return await _databaseUseCase.getAllAds();
  }

  bool isAdFavorite(AdEntity ad) {
    if (_accountUseCase.favoriteAds == null) return false;
    for (final favouriteAd in _accountUseCase.favoriteAds!) {
      if (favouriteAd.dateOfAd.compareTo(ad.dateOfAd) == 0) return true;
    }
    return false;
  }
}
