import 'dart:convert';

import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/httpRepo.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/data/models/tyreModel.dart';
import 'package:tyres_frontend/features/Tyres/data/models/tyrePositionModel.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEnums.dart';

abstract class TyreDatasource {
  Future<int> getNextId();
  Future<TyreModel> getTyreData(int id);
  Future<List<TyreModel>> getTyresForATruck(int truckId);
  Future<NoParams> installTyreToATruck(TyreModel tyre, bool newTyre);
  Future<NoParams> removeTyreFromATruck(int tyreId);
  Future<NoParams> addTyre(TyreModel tyre);
  Future<NoParams> deleteTyre(int id);
  Future<List<TyreModel>> getTyreBySerial(String serial);
  Future<NoParams> changeTyrePosition(
      int tyreId, TyrePositionModel newPosition);
}

class TyreDatasourceImpl implements TyreDatasource {
  final HttpRepo httpRepo;

  TyreDatasourceImpl({required this.httpRepo});
  @override
  Future<NoParams> addTyre(TyreModel tyre) async {
    var result = await httpRepo.put(
        host: "addTyre?serial=${tyre.serial}&model=${tyre.model}");
    if (result.statusCode == 200) {
      return NoParams();
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<NoParams> changeTyrePosition(
      int tyreId, TyrePositionModel newPosition) async {
    var result = await httpRepo.put(
        host: "transfereTyreOnSameTruck?tyreId=$tyreId",
        body: newPosition.toJson());
    if (result.statusCode == 200) {
      return NoParams();
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<NoParams> deleteTyre(int id) async {
    // Mock implementation for deleting a tyre
    return Future.value(NoParams());
  }

  @override
  Future<List<TyreModel>> getTyreBySerial(String serial) async {
    var result = await httpRepo.get(host: "searchTyre?serial=$serial");
    if (result.statusCode == 200) {
      return (json.decode(result.data as String) as List<dynamic>)
          .map((e) => TyreModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<TyreModel> getTyreData(int id) async {
    // Mock implementation for getting tyre data by id
    return Future.value(TyreModel(
      id: id,
      truckId: 101,
      // startMileage: 5000,
      // endMileage: null,
      serial: "ABC123",
      model: "Michelin X Line",
      position: TyrePositionModel(
        direction: enum_TyreDirection.Outer,
        side: enum_TyreSide.Left,
        index: 1,
      ),
    ));
  }

  @override
  Future<List<TyreModel>> getTyresForATruck(int truckId) async {
    // Mock implementation for getting all tyres for a truck
    return Future.value([
      TyreModel(
        id: 1,
        truckId: truckId,
        // startMileage: 5000,
        // endMileage: null,
        serial: "ABC123",
        model: "Michelin X Line",
        position: TyrePositionModel(
          direction: enum_TyreDirection.Outer,
          side: enum_TyreSide.Left,
          index: 1,
        ),
      ),
      TyreModel(
        id: 2,
        truckId: truckId,
        // startMileage: 6000,
        // endMileage: null,
        serial: "DEF456",
        model: "Bridgestone R250",
        position: TyrePositionModel(
          direction: enum_TyreDirection.Inner,
          side: enum_TyreSide.Right,
          index: 2,
        ),
      ),
    ]);
  }

  @override
  Future<NoParams> installTyreToATruck(TyreModel tyre, bool newTyre) async {
    var result = await httpRepo.post(
        host: "installTyre?newTyre=$newTyre", body: tyre.toJson());
    if (result.statusCode == 200) {
      return NoParams();
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<NoParams> removeTyreFromATruck(int tyreId) async {
    var result = await httpRepo.put(host: "removeTyreFromTruck?tyreId=$tyreId");
    if (result.statusCode == 200) {
      return NoParams();
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }

  @override
  Future<int> getNextId() async {
    var result = await httpRepo.get(host: "getNewId");
    if (result.statusCode == 200) {
      return int.parse((result.data ?? "0") as String);
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }
}
