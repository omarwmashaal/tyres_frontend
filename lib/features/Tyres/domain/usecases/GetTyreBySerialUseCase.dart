import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Tyres/domain/entities/tyreEntity.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';

class GetTyreBySerialUseCase extends UseCase<List<TyreEntity>, String> {
  final TyresRepo tyresRepo;

  GetTyreBySerialUseCase({required this.tyresRepo});

  @override
  Future<Either<Failure, List<TyreEntity>>> call(String serial) async {
    return await tyresRepo.getTyreBySerial(serial).then((value) {
      return value.fold(
        (l) => Left(l..message = "Get Tyre By Serial: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
