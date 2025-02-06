import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class GetNextTyreIdUseCase extends UseCase<int, NoParams> {
  final TyresRepo tyresRepo;

  GetNextTyreIdUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await tyresRepo.getNextId().then((value) {
      return value.fold(
        (l) => Left(l..message = "Get Next Tyre Id: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
