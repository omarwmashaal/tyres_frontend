import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TruckModel {
  final int? id;
  final String? platNo;
  final int? currentMileage;
  final List<TyresEntity>? tyres;

  TruckModel({
    this.id,
    this.platNo,
    this.currentMileage,
    this.tyres,
  });

  TruckModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? platNo,
    ValueGetter<int?>? currentMileage,
    ValueGetter<List<TyresEntity>?>? tyres,
  }) {
    return TruckModel(
      id: id != null ? id() : this.id,
      platNo: platNo != null ? platNo() : this.platNo,
      currentMileage: currentMileage != null ? currentMileage() : this.currentMileage,
      tyres: tyres != null ? tyres() : this.tyres,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'platNo': platNo,
      'currentMileage': currentMileage,
      'tyres': tyres?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory TruckModel.fromMap(Map<String, dynamic> map) {
    return TruckModel(
      id: map['id']?.toInt(),
      platNo: map['platNo'],
      currentMileage: map['currentMileage']?.toInt(),
      tyres: map['tyres'] != null ? List<TyresEntity>.from(map['tyres']?.map((x) => TyresEntity.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TruckModel.fromJson(String source) => TruckModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Truckentity(id: $id, platNo: $platNo, currentMileage: $currentMileage, tyres: $tyres)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TruckModel &&
        other.id == id &&
        other.platNo == platNo &&
        other.currentMileage == currentMileage &&
        listEquals(other.tyres, tyres);
  }

  @override
  int get hashCode {
    return id.hashCode ^ platNo.hashCode ^ currentMileage.hashCode ^ tyres.hashCode;
  }
}
