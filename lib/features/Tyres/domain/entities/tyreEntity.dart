import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';

class TyreEntity {
  final int? id;
  final int? truckId;
  final int? startMileage;
  final int? endMileage;
  final String? serial;
  final String? model;
  final TyrePositionEntity? position;

  TyreEntity({
    this.id,
    this.truckId,
    this.startMileage,
    this.endMileage,
    this.serial,
    this.model,
    this.position,
  });
}
