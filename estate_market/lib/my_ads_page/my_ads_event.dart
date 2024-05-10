part of 'my_ads_bloc.dart';

abstract class MyAdsEvent {
  const MyAdsEvent();
}

class InitMyAdsPageEvent extends MyAdsEvent {}

class SetMyAdsEvent extends MyAdsEvent {
  final List<AdEntity?> ads;

  SetMyAdsEvent({required this.ads});
}
