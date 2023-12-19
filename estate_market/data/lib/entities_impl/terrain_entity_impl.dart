import 'package:data/entities_impl/property_entity_impl.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:domain/entities/ad_entity.dart';

class TerrainEntityImpl extends PropertyEntityImpl implements TerrainEntity {
  @override
  bool isInBuildUpArea;

  @override
  LandUseCategories landUseCategory;

  TerrainEntityImpl(
      {required this.isInBuildUpArea,
      required this.landUseCategory,
      required double surface,
      required double price,
      required bool isNegotiable,
      int? constructionYear})
      : super(surface: surface, price: price, isNegotiable: isNegotiable, constructionYear: constructionYear);

  @override
  Map<String, dynamic> toJson() {
    final json = {
      'type': AdCategory.terrain.index,
      'surface': surface,
      'price': price,
      'isNegotiable': isNegotiable,
      'isInBuildUpArea': isInBuildUpArea,
      'landUseCategory': landUseCategory.index,
    };
    if (constructionYear != null) {
      json.addAll({'constructionYear': constructionYear!});
    }
    return json;
  }

  factory TerrainEntityImpl.fromJson(Map<String, Object?> json) {
    return TerrainEntityImpl(
      surface: (json['surface'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isNegotiable: json['isNegotiable'] as bool,
      isInBuildUpArea: json['isInBuildUpArea'] as bool,
      landUseCategory: LandUseCategories.values[json['landUseCategory'] as int],
      constructionYear: (json.containsKey('constructionYear')) ? json['constructionYear'] as int : null,
    );
  }
}
