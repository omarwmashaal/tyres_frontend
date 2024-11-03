import 'dart:convert';

import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEnums.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';

class TyrePositionModel {
  final enum_TyreDirection direction;
  final enum_TyreSide side;
  final int index;

  TyrePositionModel({
    required this.direction,
    required this.side,
    required this.index,
  });

  // Factory constructor to create a TyrePositionModel from JSON
  factory TyrePositionModel.fromJson(Map<String, dynamic> json) {
    return TyrePositionModel(
      direction: enum_TyreDirection.values[json['direction']],
      side: enum_TyreSide.values[json['side']],
      index: json['index'],
    );
  }

  // Method to convert TyrePositionModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'direction': direction.index,
      'side': side.index,
      'index': index,
    };
  }

  // Convert Model to Entity
  TyrePositionEntity toEntity() {
    return TyrePositionEntity(
      direction: direction,
      side: side,
      index: index,
    );
  }

  // Factory constructor to create a TyrePositionModel from an Entity
  factory TyrePositionModel.fromEntity(TyrePositionEntity entity) {
    return TyrePositionModel(
      direction: entity.direction,
      side: entity.side,
      index: entity.index,
    );
  }

  // copyWith method for immutability and updating fields
  TyrePositionModel copyWith({
    enum_TyreDirection? direction,
    enum_TyreSide? side,
    int? index,
  }) {
    return TyrePositionModel(
      direction: direction ?? this.direction,
      side: side ?? this.side,
      index: index ?? this.index,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TyrePositionModel && other.direction == direction && other.side == side && other.index == index;
  }

  @override
  int get hashCode => direction.hashCode ^ side.hashCode ^ index.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'direction': direction.index,
      'side': side.index,
      'index': index,
    };
  }

  factory TyrePositionModel.fromMap(Map<String, dynamic> map) {
    return TyrePositionModel(
      direction: enum_TyreDirection.values[map['direction']],
      side: enum_TyreSide.values[map['side']],
      index: map['index']?.toInt() ?? 0,
    );
  }

  @override
  String toString() => 'TyrePositionModel(direction: $direction, side: $side, index: $index)';
}
