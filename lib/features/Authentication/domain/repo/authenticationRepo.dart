import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';

abstract class Authenticationrepo {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, NoParams>> register(String email, String password, String name);
}
