import 'package:domain/entities/garage_entity.dart';
import 'package:domain/repositories/database_repository.dart';

import '../entities/ad_entity.dart';
import '../entities/document_reference_entity.dart';

class DatabaseUseCase {
  final DatabaseRepository _databaseRepository;

  DatabaseUseCase({required DatabaseRepository databaseRepository}) : _databaseRepository = databaseRepository;

  Future<List<AdEntity>> getAllAds() async {
    final resp = await _databaseRepository.getAllAds();
    return resp;
  }

  Future<DocumentReferenceEntity> insertGarageEntity(double surface, double price, bool isNegotiable,
      int? constructionYear, ParkingType parkingType, int capacity) async {
    return await _databaseRepository.insertGarageEntity(
        surface, price, isNegotiable, constructionYear, parkingType, capacity);
  }

  Future<void> insertAdEntity(String title, AdCategory category, String description, DocumentReferenceEntity property,
      ListingType listingType) async {
    await _databaseRepository.insertAdEntity(title, category, description, property, listingType);
  }
}
