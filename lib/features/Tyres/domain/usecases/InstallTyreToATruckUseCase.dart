import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class InstallTyreToATruckUseCase extends UseCase<NoParams, InstallTyreParams> {
  final TyresRepo tyresRepo;

  InstallTyreToATruckUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, NoParams>> call(InstallTyreParams params) async {
    return await tyresRepo.installTyreToATruck(params.tyreId, params.truckId).then((value) {
      return value.fold(
        (l) => Left(l..message = "Install Tyre To A Truck: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}

class InstallTyreParams {
  final int tyreId;
  final int truckId;

  InstallTyreParams({required this.tyreId, required this.truckId});
}
