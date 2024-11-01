import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/datasource/authentication_datasource.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';

class Authenticationrepoimpl implements Authenticationrepo {
  final AuthenticationDatasource authenticationDatasource;

  Authenticationrepoimpl({required this.authenticationDatasource});
  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    try {
      return Right(await authenticationDatasource.login(email, password));
    } on Exception {
      return Left(Failure_HttpBadRequest(message: ""));
    }
  }

  @override
  Future<Either<Failure, NoParams>> register(String email, String password, String name) async {
    try {
      return Right(await authenticationDatasource.register(email, password, name));
    } on FailureException catch (e) {
      return Left(e.failure);
    }
  }
}
