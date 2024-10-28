import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class GetTyresForATruckUseCase extends UseCase<List<TyreEntity>, int> {
  final TyresRepo tyresRepo;

  GetTyresForATruckUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, List<TyreEntity>>> call(int truckId) async {
    return await tyresRepo.getTyresForATruck(truckId).then((value) {
      return value.fold(
        (l) => Left(l..message = "Get Tyres For A Truck: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
