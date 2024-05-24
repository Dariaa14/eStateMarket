import '../entities/ad_entity.dart';

abstract class FilterRepository {
  Stream<List<AdEntity>> streamAds();

  void setCurrentCategory(AdCategory? category);
}
