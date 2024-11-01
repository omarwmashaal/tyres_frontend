import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/data/datasource/tyreDatasource.dart';
import 'package:tyres_frontend/features/Tyres/data/models/tyreModel.dart';
import 'package:tyres_frontend/features/Tyres/data/models/tyrePositionModel.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class TyresRepoImpl implements TyresRepo {
  final TyreDatasource tyreDatasource;

  TyresRepoImpl({
    required this.tyreDatasource,
  });

  @override
  Future<Either<Failure, TyreEntity>> getTyreData(int id) async {
    try {
      final tyreModel = await tyreDatasource.getTyreData(id);
      final tyreEntity = tyreModel.toEntity(); // Convert Model to Entity
      return Right(tyreEntity);
    } catch (error) {
      return Left(ServerFailure(message: "Failed to get tyre data: $error"));
    }
  }

  @override
  Future<Either<Failure, List<TyreEntity>>> getTyresForATruck(int truckId) async {
    try {
      final tyreModels = await tyreDatasource.getTyresForATruck(truckId);
      final tyreEntities = tyreModels.map((model) => model.toEntity()).toList(); // Convert Models to Entities
      return Right(tyreEntities);
    } catch (error) {
      return Left(ServerFailure(message: "Failed to get tyres for truck: $error"));
    }
  }

  @override
  Future<Either<Failure, NoParams>> installTyreToATruck(int tyreId, int truckId) async {
    try {
      await tyreDatasource.installTyreToATruck(tyreId, truckId);
      return Right(NoParams());
    } catch (error) {
      return Left(ServerFailure(message: "Failed to install tyre to truck: $error"));
    }
  }

  @override
  Future<Either<Failure, NoParams>> removeTyreFromATruck(int tyreId, int truckId) async {
    try {
      await tyreDatasource.removeTyreFromATruck(tyreId, truckId);
      return Right(NoParams());
    } catch (error) {
      return Left(ServerFailure(message: "Failed to remove tyre from truck: $error"));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addTyre(TyreEntity tyre) async {
    try {
      final tyreModel = TyreModel.fromEntity(tyre); // Convert Entity to Model
      await tyreDatasource.addTyre(tyreModel);
      return Right(NoParams());
    } catch (error) {
      return Left(ServerFailure(message: "Failed to add tyre: $error"));
    }
  }

  @override
  Future<Either<Failure, NoParams>> deleteTyre(int id) async {
    try {
      await tyreDatasource.deleteTyre(id);
      return Right(NoParams());
    } catch (error) {
      return Left(ServerFailure(message: "Failed to delete tyre: $error"));
    }
  }

  @override
  Future<Either<Failure, List<TyreEntity>>> getTyreBySerial(String serial) async {
    try {
      final tyresModel = await tyreDatasource.getTyreBySerial(serial);
      final tyres = tyresModel.map((e) => e.toEntity()).toList(); // Convert Model to Entity
      return Right(tyres);
    } catch (error) {
      return Left(ServerFailure(message: "Failed to get tyre by serial: $error"));
    }
  }

  @override
  Future<Either<Failure, NoParams>> changeTyrePosition(int truckId, TyrePositionEntity newPosition) async {
    try {
      final positionModel = TyrePositionModel.fromEntity(newPosition); // Convert Entity to Model
      await tyreDatasource.changeTyrePosition(truckId, positionModel);
      return Right(NoParams());
    } catch (error) {
      return Left(ServerFailure(message: "Failed to change tyre position: $error"));
    }
  }
}
