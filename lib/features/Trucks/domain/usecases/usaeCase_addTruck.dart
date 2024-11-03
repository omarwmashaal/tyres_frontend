import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/data/models/registerModel.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/domain/repo/truckRepo.dart';

class AddTruckUseCase extends UseCase<TruckEntity, TruckEntity> {
  final Truckrepo truckrepo;

  AddTruckUseCase({required this.truckrepo});
  @override
  Future<Either<Failure, TruckEntity>> call(TruckEntity params) async {
    try {
      assert(params.platNo != null, "Invalid Plat No");
      assert(params.currentMileage != null, "Invalid Milleage");
    } on AssertionError catch (e) {
      return Left(Failure_HttpBadRequest(message: e.message?.toString() ?? ""));
    }
    return await truckrepo.addTrcuk(params).then((value) {
      return value.fold(
        (l) => Left(l..message = "Add Truck: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
