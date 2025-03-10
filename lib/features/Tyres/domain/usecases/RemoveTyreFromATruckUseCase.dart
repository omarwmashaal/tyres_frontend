import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class RemoveTyreFromATruckUseCase extends UseCase<NoParams, int> {
  final TyresRepo tyresRepo;

  RemoveTyreFromATruckUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, NoParams>> call(int params) async {
    return await tyresRepo.removeTyreFromATruck(params).then((value) {
      return value.fold(
        (l) => Left(l..message = "Remove Tyre From A Truck: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
