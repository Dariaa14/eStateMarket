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
}
