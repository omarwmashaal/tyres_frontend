import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';

abstract class Truckrepo {
  Future<Either<Failure, List<TruckEntity>>> searchTrucks(String search);
  Future<Either<Failure, TruckEntity>> addTrcuk(TruckEntity truck);
  Future<Either<Failure, NoParams>> removeTruck(int id);
  Future<Either<Failure, TruckEntity>> udpateTruckData(TruckEntity data);
  Future<Either<Failure, TruckEntity>> getTruckData(int id);
}
