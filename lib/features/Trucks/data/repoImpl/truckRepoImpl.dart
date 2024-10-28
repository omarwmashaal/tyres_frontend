import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Trucks/data/datasource/truckDatasource.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/domain/repo/truckRepo.dart';

class Truckrepoimpl implements Truckrepo {
  final Truckdatasource truckdatasource;

  Truckrepoimpl({required this.truckdatasource});
  @override
  Future<Either<Failure, Truckentity>> addTrcuk(Truckentity truck) async {
    try {
      return Right(await truckdatasource.addTrcuk(truck));
    } on Exception {
      return Left(Failure_HttpBadRequest(message: ""));
    }
  }

  @override
  Future<Either<Failure, Truckentity>> getTruckData(int id) async {
    try {
      return Right(await truckdatasource.getTruckData(id));
    } on Exception {
      return Left(Failure_HttpBadRequest(message: ""));
    }
  }

  @override
  Future<Either<Failure, NoParams>> removeTruck(int id) async {
    try {
      return Right(await truckdatasource.removeTruck(id));
    } on Exception {
      return Left(Failure_HttpBadRequest(message: ""));
    }
  }

  @override
  Future<Either<Failure, List<Truckentity>>> searchTrucks(String search) async {
    try {
      return Right(await truckdatasource.searchTrucks(search));
    } on Exception {
      return Left(Failure_HttpBadRequest(message: ""));
    }
  }

  @override
  Future<Either<Failure, Truckentity>> udpateTruckData(Truckentity data) async {
    try {
      return Right(await truckdatasource.udpateTruckData(data));
    } on Exception {
      return Left(Failure_HttpBadRequest(message: ""));
    }
  }
}
