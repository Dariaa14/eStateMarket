import '../entities/ad_entity.dart';

abstract class DatabaseRepository {
  Future<List<AdEntity>> getAllAds();
}
