import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class DeleteTyreUseCase extends UseCase<NoParams, int> {
  final TyresRepo tyresRepo;

  DeleteTyreUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, NoParams>> call(int id) async {
    return await tyresRepo.deleteTyre(id).then((value) {
      return value.fold(
        (l) => Left(l..message = "Delete Tyre: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
