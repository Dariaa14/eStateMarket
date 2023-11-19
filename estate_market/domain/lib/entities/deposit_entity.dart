import 'package:domain/entities/property_entity.dart';

enum DepositType {
  deposit,
  distribution,
  production,
}

abstract class DepositEntity extends PropertyEntity {
  final double height;
  final double usableSurface;
  final double administrativeSurface;
  final DepositType depositType;
  // security
  // access
  final int parkingSpaces;
  // infrastructure
  // facilities

  DepositEntity(
      {required this.height,
      required this.usableSurface,
      required this.administrativeSurface,
      required this.depositType,
      required this.parkingSpaces,
      required super.constructionYear,
      required super.surface,
      required super.price,
      required super.isNegotiable});
}
