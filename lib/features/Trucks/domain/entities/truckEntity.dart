class Truckentity {
  final int? id;
  final String? platNo;
  final int? currentMileage;
  final List<TyresEntity>? tyres;

  Truckentity({required this.id, required this.platNo, required this.currentMileage, this.tyres});
}
