import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

class TruckModel {
  final int? id;
  final String? platNo;
  final int? currentMileage;
  final List<int>? tyreIds;

  TruckModel({
    required this.id,
    required this.platNo,
    required this.currentMileage,
    this.tyreIds,
  });

  // Factory constructor to create a TruckModel from JSON
  factory TruckModel.fromJson(Map<String, dynamic> json) {
    return TruckModel(
      id: json['id'],
      platNo: json['platNo'],
      currentMileage: json['currentMileage'],
      tyreIds: json['tyreIds'] != null ? List<int>.from(json['tyreIds']) : null,
    );
  }

  // Method to convert TruckModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platNo': platNo,
      'currentMileage': currentMileage,
      'tyreIds': tyreIds != null ? List<dynamic>.from(tyreIds!) : null,
    };
  }

  // Convert Model to Entity
  TruckEntity toEntity() {
    return TruckEntity(
      id: id,
      platNo: platNo,
      currentMileage: currentMileage,
      tyreIds: tyreIds,
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
