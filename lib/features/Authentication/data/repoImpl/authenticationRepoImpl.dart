import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/sharedPreferencesDatasource.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/datasource/authentication_datasource.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';

class Authenticationrepoimpl implements Authenticationrepo {
  final AuthenticationDatasource authenticationDatasource;
  final Sharedpreferencesdatasource sharedPreferencesDatasource;

  Authenticationrepoimpl({
    required this.authenticationDatasource,
    required this.sharedPreferencesDatasource,
  });
  @override
  Future<Either<Failure, NoParams>> login(String email, String password) async {
    try {
      var token = await authenticationDatasource.login(email, password);
      await sharedPreferencesDatasource.setValue("token", token);
      return Right(NoParams());
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
