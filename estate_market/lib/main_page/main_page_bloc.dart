import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:domain/use_cases/filter_use_case.dart';
import 'package:domain/use_cases/login_use_case.dart';
import 'package:equatable/equatable.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final DatabaseUseCase _databaseUseCase = sl.get<DatabaseUseCase>();
  final FilterUseCase _filterUseCase = sl.get<FilterUseCase>();
  final LoginUseCase _loginUseCase = sl.get<LoginUseCase>();
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();

  MainPageBloc() : super(const MainPageState(ads: [])) {
    on<InitMainPageEvent>(_initMainPageEventHandler);
    on<SetAdsEvent>(_setAdsEventHandler);
    on<FavoritesButtonPressedEvent>(_favoritesButtonPressedEventHandler);

    on<CurrentUserChangedEvent>(_currentUserChangedEventHandler);

    on<DeleteAdEvent>(_deleteAdEventHandler);

    on<ChangeCurrentCategoryEvent>(_changeCurrentCategoryEventHandler);
    on<ChangeCurrentListingTypeEvent>(_changeCurrentListingTypeEventHandler);
    on<ChangePriceRangeEvent>(_changePriceRangeEventHandler);
    on<ChangeSurfaceRangeEvent>(_changeSurfaceRangeEventHandler);
    on<ChangeSearchQueryEvent>(_changeSearchQueryEventHandler);
  }

  _initMainPageEventHandler(InitMainPageEvent event, Emitter<MainPageState> emit) async {
    await _loginUseCase.initializeOnOpeningApp();
    _accountUseCase.accountStatus.listen((bool isLoggedIn) {
      add(CurrentUserChangedEvent(isLoggedIn: isLoggedIn));
    });

    _filterUseCase.adsStream.listen((List<AdEntity> ads) {
      add(SetAdsEvent(ads: ads));
    });

    _filterUseCase.setCurrentCategory(null);
    _filterUseCase.setCurrentListingType(null);
    _filterUseCase.setPriceRange(const Tuple2(null, null));
    _filterUseCase.setSurfaceRange(const Tuple2(null, null));
    _filterUseCase.setSearchQuery('');
  }

  _setAdsEventHandler(SetAdsEvent event, Emitter<MainPageState> emit) => emit(state.copyWith(ads: event.ads));

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

  _deleteAdEventHandler(DeleteAdEvent event, Emitter<MainPageState> emit) async {
    await _databaseUseCase.removeAd(ad: event.ad);
  }

  _changeCurrentCategoryEventHandler(ChangeCurrentCategoryEvent event, Emitter<MainPageState> emit) {
    _filterUseCase.setCurrentCategory(event.category);
    if (event.category == null) {
      emit(state.copyWithNullCategory());
      return;
    }
    emit(state.copyWith(currentCategory: event.category));
  }

  _changeCurrentListingTypeEventHandler(ChangeCurrentListingTypeEvent event, Emitter<MainPageState> emit) {
    _filterUseCase.setCurrentListingType(event.listingType);
    if (event.listingType == null) {
      emit(state.copyWithNullListingType());
      return;
    }
    emit(state.copyWith(currentListingType: event.listingType));
  }

  _changePriceRangeEventHandler(ChangePriceRangeEvent event, Emitter<MainPageState> emit) {
    _filterUseCase.setPriceRange(event.priceRange);
    emit(state.copyWith(priceRange: event.priceRange));
  }

  _changeSurfaceRangeEventHandler(ChangeSurfaceRangeEvent event, Emitter<MainPageState> emit) {
    _filterUseCase.setSurfaceRange(event.surfaceRange);
    emit(state.copyWith(surfaceRange: event.surfaceRange));
  }

  _changeSearchQueryEventHandler(ChangeSearchQueryEvent event, Emitter<MainPageState> emit) {
    _filterUseCase.setSearchQuery(event.searchQuery);
    emit(state.copyWith(searchQuery: event.searchQuery));
  }

  bool isAdFavorite(AdEntity ad) {
    if (_accountUseCase.favoriteAds == null) return false;
    for (final favouriteAd in _accountUseCase.favoriteAds!) {
      if (favouriteAd.dateOfAd.compareTo(ad.dateOfAd) == 0) return true;
    }
    return false;
  }

  AccountEntity? get currentAccount => _accountUseCase.currentAccount;
}
