import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';

abstract class FavoritesEntity {
  AccountEntity? account;
  AdEntity? ad;

  FavoritesEntity({this.account, this.ad});

  Future<void> setReferences();
}
