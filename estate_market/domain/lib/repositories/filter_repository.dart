import 'package:dartz/dartz.dart';

import '../entities/ad_entity.dart';

abstract class FilterRepository {
  Stream<List<AdEntity>> streamAds();

  void setCurrentCategory(AdCategory? category);
  void setCurrentListingType(ListingType? listingType);
  void setPriceRange(Tuple2<double?, double?> priceRange);
  void setSurfaceRange(Tuple2<double?, double?> surfaceRange);
  void setSearchQuery(String text);
}
