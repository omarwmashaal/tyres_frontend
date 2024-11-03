import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Tyres/data/models/tyreModel.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';

class TruckModel {
  final int? id;
  final String? platNo;
  final int? currentMileage;
  final List<int>? tyreIds;
  final List<TyreModel>? tyres;
  final DateTime? lastUpdatedMileageDate;

  TruckModel({
    required this.id,
    required this.platNo,
    required this.currentMileage,
    this.tyreIds,
    this.lastUpdatedMileageDate,
    this.tyres,
  });

  // Factory constructor to create a TruckModel from JSON
  factory TruckModel.fromJson(Map<String, dynamic> json) {
    return TruckModel(
      id: json['id'],
      platNo: json['platNo'],
      currentMileage: json['currentMileage'],
      lastUpdatedMileageDate: DateTime.tryParse(json['lastUpdatedMileageDate'] ?? "")?.toLocal(),
      tyreIds: json['tyreIds'] != null ? List<int>.from(json['tyreIds']) : null,
      tyres: json['tyres'] != null ? (json['tyres'] as List<dynamic>).map((e) => TyreModel.fromJson(e as Map<String, dynamic>)).toList() : null,
    );
  }

  // Method to convert TruckModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platNo': platNo,
      'CurrentMileage': currentMileage,
      'tyreIds': tyreIds != null ? List<dynamic>.from(tyreIds!) : null,
      'tyres': tyres != null ? List<dynamic>.from(tyres!) : null,
    };
  }

  // Convert Model to Entity
  TruckEntity toEntity() {
    return TruckEntity(
      id: id,
      platNo: platNo,
      currentMileage: currentMileage,
      tyreIds: tyreIds,
      lastUpdatedMileageDate: lastUpdatedMileageDate,
      tyres: tyres == null ? null : List<TyreEntity>.from(tyres!.map((e) => e.toEntity())),
    );
  }

  // Factory constructor to create a TruckModel from an Entity
  factory TruckModel.fromEntity(TruckEntity entity) {
    return TruckModel(
      id: entity.id,
      platNo: entity.platNo,
      currentMileage: entity.currentMileage,
      tyreIds: entity.tyreIds,
    );
  }

  // copyWith method for immutability and updating fields
  TruckModel copyWith({
    int? id,
    String? platNo,
    int? currentMileage,
    List<int>? tyreIds,
  }) {
    return TruckModel(
      id: id ?? this.id,
      platNo: platNo ?? this.platNo,
      currentMileage: currentMileage ?? this.currentMileage,
      tyreIds: tyreIds ?? this.tyreIds,
      tyres: tyres ?? this.tyres,
    );
  }

  // Override equality operator to compare object values
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruckModel && other.id == id && other.platNo == platNo && other.currentMileage == currentMileage && other.tyreIds == tyreIds;
  }

  // Override hashCode to ensure consistent hash value
  @override
  int get hashCode {
    return id.hashCode ^ platNo.hashCode ^ currentMileage.hashCode ^ tyreIds.hashCode;
  }
}
