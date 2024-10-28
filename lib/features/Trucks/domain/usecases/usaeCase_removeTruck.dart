import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/data/models/registerModel.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/domain/repo/truckRepo.dart';

class RemoveTruckUseCase extends UseCase<NoParams, int> {
  final Truckrepo truckrepo;

  RemoveTruckUseCase({required this.truckrepo});
  @override
  Future<Either<Failure, NoParams>> call(int params) async {
    return await truckrepo.removeTruck(params).then((value) {
      return value.fold(
        (l) => Left(l..message = "Remove Truck: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
