import 'package:domain/entities/property_entity.dart';

enum LandUseCategories {
  urban,
  agriculture,
  rangeland,
  forestland,
  water,
  wetland,
  barren,
}

abstract class TerrainEntity extends PropertyEntity {
  final bool isInBuildUpArea;
  final LandUseCategories landUseCategory;

  TerrainEntity(
      {required this.isInBuildUpArea,
      required this.landUseCategory,
      required super.surface,
      required super.price,
      required super.isNegotiable,
      required super.constructionYear});
}
