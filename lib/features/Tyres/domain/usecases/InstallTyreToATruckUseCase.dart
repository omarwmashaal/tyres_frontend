import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class InstallTyreToATruckUseCase extends UseCase<NoParams, TyreEntity> {
  final TyresRepo tyresRepo;

  InstallTyreToATruckUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, NoParams>> call(TyreEntity params) async {
    return await tyresRepo.installTyreToATruck(params).then((value) {
      return value.fold(
        (l) => Left(l..message = "Install Tyre To A Truck: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
