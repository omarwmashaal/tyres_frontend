import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class AddTyreUseCase extends UseCase<NoParams, TyreEntity> {
  final TyresRepo tyresRepo;

  AddTyreUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, NoParams>> call(TyreEntity tyre) async {
    if (tyre.serial?.isEmpty ?? true) {
      return Left(Failure_HttpBadRequest(message: "Serial cannot be empty"));
    }
    if (tyre.model?.isEmpty ?? true) {
      return Left(Failure_HttpBadRequest(message: "Model cannot be empty"));
    }
    return await tyresRepo.addTyre(tyre).then((value) {
      return value.fold(
        (l) => Left(l..message = "Add Tyre: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
