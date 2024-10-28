import 'package:tyres_frontend/core/httpRepo.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Trucks/data/models/truckModel.dart';

abstract class Truckdatasource {
  Future<List<TruckModel>> searchTrucks(String search);
  Future<TruckModel> addTrcuk(TruckModel truck);
  Future<NoParams> removeTruck(int id);
  Future<TruckModel> udpateTruckData(TruckModel data);
  Future<TruckModel> getTruckData(int id);
}

class TruckDatasourceImpl implements Truckdatasource {
  final HttpRepo httpRepo;

  TruckDatasourceImpl({required this.httpRepo});
  @override
  Future<TruckModel> addTrcuk(TruckModel truck) async {
    return TruckModel(id: 1, platNo: "platNo", currentMileage: 22);
  }

  @override
  Future<TruckModel> getTruckData(int id) async {
    return TruckModel(id: 1, platNo: "platNo", currentMileage: 22);
  }

  @override
  Future<NoParams> removeTruck(int id) async {
    return NoParams();
  }

  @override
  Future<List<TruckModel>> searchTrucks(String search) async {
    return [TruckModel(id: 1, platNo: "platNo", currentMileage: 22)];
  }

  @override
  Future<TruckModel> udpateTruckData(TruckModel data) async {
    return TruckModel(id: 1, platNo: "platNo", currentMileage: 22);
  }
}
