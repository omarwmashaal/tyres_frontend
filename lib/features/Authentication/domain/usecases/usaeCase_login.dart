import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';

class LoginUseCase extends UseCase<NoParams, Loginmodel> {
  final Authenticationrepo authenticationrepo;

  LoginUseCase({required this.authenticationrepo});
  @override
  Future<Either<Failure, NoParams>> call(Loginmodel params) async {
    return await authenticationrepo.login(params.email, params.password).then((value) {
      return value.fold(
        (l) => Left(l..message = "Login: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
