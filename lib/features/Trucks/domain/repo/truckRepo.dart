import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

abstract class Truckrepo {
  Future<Either<Failure, List<Truckentity>>> searchTrucks(String search);
  Future<Either<Failure, Truckentity>> addTrcuk(Truckentity truck);
  Future<Either<Failure, NoParams>> removeTruck(int id);
  Future<Either<Failure, Truckentity>> udpateTruckData(Truckentity data);
  Future<Either<Failure, Truckentity>> getTruckData(int id);
}
