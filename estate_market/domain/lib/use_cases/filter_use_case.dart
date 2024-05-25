import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../entities/ad_entity.dart';
import '../repositories/filter_repository.dart';

class FilterUseCase {
  final FilterRepository _filterRepository;
  final BehaviorSubject<List<AdEntity>> _adsController = BehaviorSubject();

  FilterUseCase({required FilterRepository filterRepository}) : _filterRepository = filterRepository {
    _filterRepository.streamAds().listen((ads) {
      _adsController.add(ads);
    });
  }

  Stream<List<AdEntity>> get adsStream => _adsController.stream;

  void setCurrentCategory(AdCategory? category) {
    _filterRepository.setCurrentCategory(category);
  }

  void setCurrentListingType(ListingType? listingType) {
    _filterRepository.setCurrentListingType(listingType);
  }

  void setPriceRange(Tuple2<double?, double?> priceRange) {
    _filterRepository.setPriceRange(priceRange);
  }

  void setSurfaceRange(Tuple2<double?, double?> surfaceRange) {
    _filterRepository.setSurfaceRange(surfaceRange);
  }

  void setSearchQuery(String text) {
    _filterRepository.setSearchQuery(text);
  }

  void dispose() {
    _adsController.close();
  }
}
