import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/data/models/registerModel.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';
import 'package:tyres_frontend/features/Trucks/domain/entities/truckEntity.dart';
import 'package:tyres_frontend/features/Trucks/domain/repo/truckRepo.dart';

class SearchTrucksUseCase extends UseCase<List<TruckEntity>, String> {
  final Truckrepo truckrepo;

  SearchTrucksUseCase({required this.truckrepo});
  @override
  Future<Either<Failure, List<TruckEntity>>> call(String params) async {
    return await truckrepo.searchTrucks(params).then((value) {
      return value.fold(
        (l) => Left(l..message = "Search Trucks: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
