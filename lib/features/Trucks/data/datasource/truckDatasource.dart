import 'package:tyres_frontend/core/httpRepo.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

abstract class Truckdatasource {
  Future<List<Truckentity>> searchTrucks(String search);
  Future<Truckentity> addTrcuk(Truckentity truck);
  Future<NoParams> removeTruck(int id);
  Future<Truckentity> udpateTruckData(Truckentity data);
  Future<Truckentity> getTruckData(int id);
}

class TruckDatasourceImpl implements Truckdatasource {
  final HttpRepo httpRepo;

  TruckDatasourceImpl({required this.httpRepo});
  @override
  Future<Truckentity> addTrcuk(Truckentity truck) async {
    return Truckentity(id: 1, platNo: "platNo", currentMileage: 22);
  }

  @override
  Future<Truckentity> getTruckData(int id) async {
    return Truckentity(id: 1, platNo: "platNo", currentMileage: 22);
  }

  @override
  Future<NoParams> removeTruck(int id) async {
    return NoParams();
  }

  @override
  Future<List<Truckentity>> searchTrucks(String search) async {
    return [Truckentity(id: 1, platNo: "platNo", currentMileage: 22)];
  }

  @override
  Future<Truckentity> udpateTruckData(Truckentity data) async {
    return Truckentity(id: 1, platNo: "platNo", currentMileage: 22);
  }
}
