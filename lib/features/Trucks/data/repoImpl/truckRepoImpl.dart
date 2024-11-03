import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Trucks/data/datasource/truckDatasource.dart';
import 'package:tyres_frontend/features/Trucks/data/models/truckModel.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/domain/repo/truckRepo.dart';

class Truckrepoimpl implements Truckrepo {
  final Truckdatasource truckdatasource;

  Truckrepoimpl({required this.truckdatasource});
  @override
  Future<Either<Failure, TruckEntity>> addTrcuk(TruckEntity truck) async {
    try {
      var truckModel = TruckModel.fromEntity(truck);
      var result = await truckdatasource.addTrcuk(truckModel);
      return Right(result.toEntity());
    } on FailureException catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, TruckEntity>> getTruckData(int id) async {
    try {
      var result = await truckdatasource.getTruckData(id);
      return Right(result.toEntity());
    } on FailureException catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> removeTruck(int id) async {
    try {
      return Right(await truckdatasource.removeTruck(id));
    } on FailureException catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<TruckEntity>>> searchTrucks(String search) async {
    try {
      var result = await truckdatasource.searchTrucks(search);
      return Right(result.map((x) => x.toEntity()).toList());
    } on FailureException catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, TruckEntity>> udpateTruckData(TruckEntity data) async {
    try {
      var truckModel = TruckModel.fromEntity(data);
      var result = await truckdatasource.udpateTruckData(truckModel);
      return Right(result.toEntity());
    } on FailureException catch (e) {
      return Left(e.failure);
    }
  }
}
