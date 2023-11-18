import 'package:domain/entities/property_entity.dart';

abstract class TerrainEntity extends PropertyEntity {
  final bool isInBuildUpArea;

  TerrainEntity(
      {required this.isInBuildUpArea, required super.surface, required super.price, required super.isNegotiable});
}
