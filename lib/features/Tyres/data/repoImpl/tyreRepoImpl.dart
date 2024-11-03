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
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }

  @override
  Future<Either<Failure, List<TyreEntity>>> getTyresForATruck(int truckId) async {
    try {
      final tyreModels = await tyreDatasource.getTyresForATruck(truckId);
      final tyreEntities = tyreModels.map((model) => model.toEntity()).toList(); // Convert Models to Entities
      return Right(tyreEntities);
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }

  @override
  Future<Either<Failure, NoParams>> installTyreToATruck(TyreEntity tyre) async {
    try {
      var tyreModel = TyreModel.fromEntity(tyre);
      await tyreDatasource.installTyreToATruck(tyreModel);
      return Right(NoParams());
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }

  @override
  Future<Either<Failure, NoParams>> removeTyreFromATruck(int tyreId) async {
    try {
      await tyreDatasource.removeTyreFromATruck(tyreId);
      return Right(NoParams());
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }

  @override
  Future<Either<Failure, NoParams>> addTyre(TyreEntity tyre) async {
    try {
      final tyreModel = TyreModel.fromEntity(tyre); // Convert Entity to Model
      await tyreDatasource.addTyre(tyreModel);
      return Right(NoParams());
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }

  @override
  Future<Either<Failure, NoParams>> deleteTyre(int id) async {
    try {
      await tyreDatasource.deleteTyre(id);
      return Right(NoParams());
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }

  @override
  Future<Either<Failure, List<TyreEntity>>> getTyreBySerial(String serial) async {
    try {
      final tyresModel = await tyreDatasource.getTyreBySerial(serial);
      final tyres = tyresModel.map((e) => e.toEntity()).toList(); // Convert Model to Entity
      return Right(tyres);
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }

  @override
  Future<Either<Failure, NoParams>> changeTyrePosition(int truckId, TyrePositionEntity newPosition) async {
    try {
      final positionModel = TyrePositionModel.fromEntity(newPosition); // Convert Entity to Model
      await tyreDatasource.changeTyrePosition(truckId, positionModel);
      return Right(NoParams());
    } on FailureException catch (error) {
      return Left(error.failure!);
    }
  }
}
