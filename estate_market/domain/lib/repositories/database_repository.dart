import '../entities/ad_entity.dart';
import '../entities/document_reference_entity.dart';
import '../entities/garage_entity.dart';

abstract class DatabaseRepository {
  Future<List<AdEntity>> getAllAds();

  Future<DocumentReferenceEntity> insertGarageEntity(
      double surface, double price, bool isNegotiable, int? constructionYear, ParkingType parkingType, int capacity);
  Future<void> insertAdEntity(
      String title, AdCategory category, String description, DocumentReferenceEntity property, ListingType listingType);
}
