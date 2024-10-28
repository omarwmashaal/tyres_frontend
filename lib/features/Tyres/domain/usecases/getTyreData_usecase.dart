import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class GetTyreDataUseCase extends UseCase<TyreEntity, int> {
  final TyresRepo tyresRepo;

  GetTyreDataUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, TyreEntity>> call(int id) async {
    return await tyresRepo.getTyreData(id).then((value) {
      return value.fold(
        (l) => Left(l..message = "Get Tyre Data: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
