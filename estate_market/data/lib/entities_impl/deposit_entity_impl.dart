import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'property_entity_impl.dart';

class DepositEntityImpl extends PropertyEntityImpl implements DepositEntity {
  @override
  double administrativeSurface;

  @override
  DepositType depositType;

  @override
  double height;

  @override
  int parkingSpaces;

  @override
  double usableSurface;

  DepositEntityImpl(
      {required this.height,
      required this.usableSurface,
      required this.administrativeSurface,
      required this.depositType,
      required this.parkingSpaces,
      required double surface,
      required double price,
      required bool isNegotiable,
      int? constructionYear})
      : super(surface: surface, price: price, isNegotiable: isNegotiable, constructionYear: constructionYear);

  @override
  Map<String, dynamic> toJson() {
    final json = {
      'type': AdCategory.deposit.index,
      'height': height,
      'usableSurface': usableSurface,
      'administrativeSurface': administrativeSurface,
      'depositType': depositType.index,
      'parkingSpaces': parkingSpaces,
      'price': price,
      'isNegotiable': isNegotiable,
    };
    if (constructionYear != null) {
      json.addAll({'constructionYear': constructionYear!});
    }
    return json;
  }

  factory DepositEntityImpl.fromJson(Map<String, Object?> json) {
    return DepositEntityImpl(
        height: (json['height'] as num).toDouble(),
        usableSurface: (json['usableSurface'] as num).toDouble(),
        administrativeSurface: (json['administrativeSurface'] as num).toDouble(),
        depositType: DepositType.values[json['depositType'] as int],
        parkingSpaces: (json['parkingSpaces'] as num).toInt(),
        price: (json['price'] as num).toDouble(),
        isNegotiable: json['isNegotiable'] as bool,
        constructionYear: (json.containsKey('constructionYear')) ? json['constructionYear'] as int : null,
        surface: (json['usableSurface'] as num).toDouble() + (json['administrativeSurface'] as num).toDouble());
  }
}
