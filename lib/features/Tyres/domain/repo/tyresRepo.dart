import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';

abstract class TyresRepo {
  Future<Either<Failure, int>> getNextId();
  Future<Either<Failure, TyreEntity>> getTyreData(int id);
  Future<Either<Failure, List<TyreEntity>>> getTyresForATruck(int truckId);
  Future<Either<Failure, NoParams>> installTyreToATruck(
      TyreEntity tyre, bool newTyre);
  Future<Either<Failure, NoParams>> removeTyreFromATruck(int tyreId);
  Future<Either<Failure, NoParams>> addTyre(TyreEntity tyre);
  Future<Either<Failure, NoParams>> deleteTyre(int id);
  Future<Either<Failure, List<TyreEntity>>> getTyreBySerial(String serial);
  Future<Either<Failure, NoParams>> changeTyrePosition(
      int truckId, TyrePositionEntity newPosition);
}
