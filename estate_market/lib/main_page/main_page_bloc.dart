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
  }

  _initMainPageEventHandler(InitMainPageEvent event, Emitter<MainPageState> emit) async {
    await _loginUseCase.initializeCurrentToken();
    // final ads = await _databaseUseCase.getAllAds();
    // emit(state.copyWith(ads: ads));
  }

  _favoritesButtonPressedEventHandler(FavoritesButtonPressedEvent event, Emitter<MainPageState> emit) async {
    if (_accountUseCase.isUserLoggedIn()) {
      if (_accountUseCase.favoriteAds!.contains(event.ad)) {
      } else {
        _accountUseCase.addFavoriteAd(event.ad);
      }
      emit(state.copyWith(favoritesChanged: !state.favoritesChanged));
    }
  }

  Future<List<AdEntity>> getAdsTest() async {
    return await _databaseUseCase.getAllAds();
  }

  bool isUserLoggedIn() {
    return _accountUseCase.isUserLoggedIn();
  }

  bool isAdFavorite(AdEntity ad) {
    if (_accountUseCase.favoriteAds == null) return false;
    return _accountUseCase.favoriteAds!.contains(ad);
  }
}
