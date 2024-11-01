import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/httpRepo.dart';
import 'package:tyres_frontend/core/remoteConstats.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';

abstract class AuthenticationDatasource {
  Future<String> login(String email, String password);
  Future<NoParams> register(String email, String password, String name);
}

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final HttpRepo httpRepo;

  AuthenticationDatasourceImpl({required this.httpRepo});
  @override
  Future<String> login(String email, String password) async {
    var result = await httpRepo.get(host: "$authenticationController?email=$email&password=$password");
    if (result.statusCode == 200) {
      return result.data as String;
    } else
      throw Exception();
  }

  @override
  Future<NoParams> register(String email, String password, String name) async {
    var result = await httpRepo.get(host: "register?email=$email&password=$password&name=$name");
    if (result.statusCode == 200) {
      return NoParams();
    } else
      throw FailureException(
        failure: FailureFactory.createFailure(
          result.statusCode,
          result.errorMessage ?? "Unknown Error",
        ),
      );
  }
}
