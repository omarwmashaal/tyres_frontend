import 'dart:convert';

import 'package:tyres_frontend/core/failure.dart';
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
    var result = await httpRepo.post(host: "addTruck", body: truck.toJson());
    if (result.statusCode == 200) {
      return TruckModel.fromJson((json.decode(result.data as String)));
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<TruckModel> getTruckData(int id) async {
    var result = await httpRepo.get(host: "getTruck?id=$id");
    if (result.statusCode == 200) {
      return TruckModel.fromJson((json.decode(result.data as String)));
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<NoParams> removeTruck(int id) async {
    return NoParams();
  }

  @override
  Future<List<TruckModel>> searchTrucks(String search) async {
    var result = await httpRepo.get(host: "searchTrucks?${search.isEmpty ? "" : "search=$search"}");
    if (result.statusCode == 200) {
      return (json.decode(result.data as String) as List<dynamic>).map((e) => TruckModel.fromJson(e as Map<String, dynamic>)).toList();
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<TruckModel> udpateTruckData(TruckModel data) async {
    var result = await httpRepo.put(host: "updateTruck", body: data.toJson());
    if (result.statusCode == 200) {
      return TruckModel.fromJson((json.decode(result.data as String)));
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }
}
