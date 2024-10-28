import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class ChangeTyrePositionUseCase extends UseCase<NoParams, ChangeTyrePositionParams> {
  final TyresRepo tyresRepo;

  ChangeTyrePositionUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, NoParams>> call(ChangeTyrePositionParams params) async {
    return await tyresRepo.changeTyrePosition(params.truckId, params.newPosition).then((value) {
      return value.fold(
        (l) => Left(l..message = "Change Tyre Position: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}

class ChangeTyrePositionParams {
  final int truckId;
  final TyrePositionEntity newPosition;

  ChangeTyrePositionParams({required this.truckId, required this.newPosition});
}
