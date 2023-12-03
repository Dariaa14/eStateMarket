import 'package:domain/repositories/database_repository.dart';

import '../entities/ad_entity.dart';

class DatabaseUseCase {
  final DatabaseRepository _databaseRepository;

  DatabaseUseCase({required DatabaseRepository databaseRepository}) : _databaseRepository = databaseRepository;

  Future<List<AdEntity>> getAllAds() async {
    final resp = await _databaseRepository.getAllAds();
    return resp;
  }
}
