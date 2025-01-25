import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';

class TyreEntity {
  final int? id;
  final int? truckId;
  final int? startMileage;
  final int? endMileage;
  final int? totalMileage;
  final String? serial;
  final String? model;
  final TyrePositionEntity? position;
  final DateTime? installedDate;
  final DateTime? addedDate;
  final String? currentTruckPlateNo;

  TyreEntity({
    this.id,
    this.truckId,
    this.startMileage,
    this.endMileage,
    this.totalMileage,
    this.serial,
    this.model,
    this.position,
    this.installedDate,
    this.addedDate,
    this.currentTruckPlateNo,
  });
}
