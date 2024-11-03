import 'package:intl/intl.dart';
import 'package:tyres_frontend/features/Tyres/data/models/tyrePositionModel.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';

class TyreModel {
  final int? id;
  final int? truckId;
  final int? startMileage;
  final int? endMileage;
  final int? totalMileage;
  final String? serial;
  final String? model;
  final TyrePositionModel? position;
  final DateTime? installedDate;
  final DateTime? addedDate;

  // Constructor
  TyreModel({
    this.id,
    this.truckId,
    this.startMileage,
    this.endMileage,
    this.totalMileage,
    this.serial,
    this.model,
    this.position,
    this.addedDate,
    this.installedDate,
  });

  /// Factory method to create a `TyreModel` from an entity.
  /// Adjust the entity class and field names as per your domain model.
  factory TyreModel.fromEntity(TyreEntity entity) {
    return TyreModel(
      id: entity.id,
      truckId: entity.truckId,
      startMileage: entity.startMileage,
      endMileage: entity.endMileage,
      totalMileage: entity.totalMileage,
      serial: entity.serial,
      model: entity.model,
      position: entity.position == null ? null : TyrePositionModel.fromEntity(entity.position!),
    );
  }

  /// Method to convert `TyreModel` to an entity.
  /// Adjust the entity class and field names as per your domain model.
  TyreEntity toEntity() {
    return TyreEntity(
      id: this.id,
      truckId: this.truckId,
      startMileage: this.startMileage,
      endMileage: this.endMileage,
      totalMileage: this.totalMileage,
      serial: this.serial,
      model: this.model,
      addedDate: this.addedDate,
      installedDate: this.installedDate,
      position: this.position?.toEntity(),
    );
  }

  /// Factory method to create a `TyreModel` from JSON.
  factory TyreModel.fromJson(Map<String, dynamic> json) {
    return TyreModel(
      id: json['id'] as int?,
      truckId: json['truckId'] as int?,
      startMileage: json['startMileage'] as int?,
      endMileage: json['endMileage'] as int?,
      totalMileage: json['totalMileage'] as int?,
      serial: json['serial'] as String?,
      model: json['model'] as String?,
      addedDate: DateTime.tryParse(json['addedDate'] ?? "")?.toLocal(),
      installedDate: DateTime.tryParse(json['installedDate'] ?? "")?.toLocal(),
      position: json['position'] != null ? TyrePositionModel.fromJson(json['position'] as Map<String, dynamic>) : null,
    );
  }

  /// Method to convert a `TyreModel` to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'truckId': truckId,
      'startMileage': startMileage,
      'endMileage': endMileage,
      'totalMileage': totalMileage,
      'serial': serial,
      'model': model,
      'position': position?.toJson(),
    };
  }
}
