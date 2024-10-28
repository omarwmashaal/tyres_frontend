import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';

abstract class UseCases<O, I> {
  Future<Either<Failure, O>> call(I params);
}

class NoParams {}
