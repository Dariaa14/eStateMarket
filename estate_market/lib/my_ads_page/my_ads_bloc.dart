import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/dependency_injector/di.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:equatable/equatable.dart';

part 'my_ads_event.dart';
part 'my_ads_state.dart';

class MyAdsBloc extends Bloc<MyAdsEvent, MyAdsState> {
  final AccountUseCase _accountUseCase = sl.get<AccountUseCase>();
  late StreamSubscription<List<AdEntity?>> _myAdsSubscription;

  MyAdsBloc() : super(const MyAdsState(ads: [])) {
    on<InitMyAdsPageEvent>(_initMyAdsPageEventHandler);
    on<SetMyAdsEvent>(_setFavoritesEventHandler);
  }

  _initMyAdsPageEventHandler(InitMyAdsPageEvent event, Emitter<MyAdsState> emit) {
    add(SetMyAdsEvent(ads: _accountUseCase.myAds ?? []));
    _myAdsSubscription = _accountUseCase.myAdsStream.listen((List<AdEntity?> ads) {
      add(SetMyAdsEvent(ads: ads));
    });
  }

  _setFavoritesEventHandler(SetMyAdsEvent event, Emitter<MyAdsState> emit) => emit(state.copyWith(ads: event.ads));

  @override
  Future<void> close() {
    _myAdsSubscription.cancel();
    return super.close();
  }
}
