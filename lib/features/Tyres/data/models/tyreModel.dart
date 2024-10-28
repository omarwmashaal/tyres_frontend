import 'package:tyres_frontend/features/Tyres/data/models/tyrePositionModel.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';

class TyreModel {
  final int? id;
  final int? truckId;
  final int? startMileage;
  final int? endMileage;
  final String? serial;
  final String? model;
  final TyrePositionModel? position;

  TyreModel({
    required this.id,
    required this.truckId,
    required this.startMileage,
    required this.endMileage,
    required this.serial,
    required this.model,
    required this.position,
  });

  // Convert Model to Entity
  TyreEntity toEntity() {
    return TyreEntity(
      id: id,
      truckId: truckId,
      startMileage: startMileage,
      endMileage: endMileage,
      serial: serial,
      model: model,
      position: position?.toEntity(),
    );
  }

  // Convert Entity to Model
  factory TyreModel.fromEntity(TyreEntity entity) {
    return TyreModel(
      id: entity.id,
      truckId: entity.truckId,
      startMileage: entity.startMileage,
      endMileage: entity.endMileage,
      serial: entity.serial,
      model: entity.model,
      position: entity.position != null ? TyrePositionModel.fromEntity(entity.position!) : null,
    );
  }
}
