import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';

class TruckEntity {
  final int? id;
  final String? platNo;
  final int? currentMileage;
  final List<int>? tyreIds;
  final List<TyreEntity>? tyres;
  final DateTime? lastUpdatedMileageDate;

  TruckEntity({
    required this.id,
    required this.platNo,
    required this.currentMileage,
    this.tyreIds,
    this.tyres,
    this.lastUpdatedMileageDate,
  });
}
