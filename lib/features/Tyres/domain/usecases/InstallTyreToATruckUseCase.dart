import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyrePositionEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class InstallTyreToATruckUseCase extends UseCase<String, InstalltyretoatruckParams> {
  final TyresRepo tyresRepo;

  InstallTyreToATruckUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, String>> call(InstalltyretoatruckParams params) async {
    if (params.tyre.serial?.isEmpty ?? true) {
      return Left(Failure_HttpBadRequest(message: "Serial cannot be empty"));
    }

    return await tyresRepo.installTyreToATruck(params.tyre, params.newTyre).then((value) {
      return value.fold(
        (l) => Left(l..message = "Install Tyre To A Truck: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}

class InstalltyretoatruckParams {
  final TyreEntity tyre;
  final bool newTyre;
  InstalltyretoatruckParams({
    required this.tyre,
    required this.newTyre,
  });
}
