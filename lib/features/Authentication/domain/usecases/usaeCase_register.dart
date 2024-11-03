import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/data/models/registerModel.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';

class RegisterUseCase extends UseCase<NoParams, Registermodel> {
  final Authenticationrepo authenticationrepo;

  RegisterUseCase({required this.authenticationrepo});
  @override
  Future<Either<Failure, NoParams>> call(Registermodel params) async {
    try {
      assert(params.email.contains("@"), "Invalid email format");
      assert(params.email.isNotEmpty, "Invalid email format");
      assert(params.name.isNotEmpty, "Invalid name");
      assert(params.password.length > 3, "Password must be at least 4 characters");
    } on AssertionError catch (e) {
      return Left(Failure_HttpBadRequest(message: e.message?.toString() ?? ""));
    }
    return await authenticationrepo.register(params.email, params.password, params.name).then((value) {
      return value.fold(
        (l) => Left(l..message = "Register: ${l.message}"),
        (r) => Right(r),
      );
    });
  }
}
