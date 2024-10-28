import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/data/models/registerModel.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';

class RegisterUseCase extends UseCases<NoParams, Registermodel> {
  final Authenticationrepo authenticationrepo;

  RegisterUseCase({required this.authenticationrepo});
  @override
  Future<Either<Failure, NoParams>> call(Registermodel params) async {
    return await authenticationrepo.register(params.email, params.password, params.name).then((value) {
      return value.fold(
        (l) => Left(l..message = "Register: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
