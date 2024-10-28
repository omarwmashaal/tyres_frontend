import 'package:tyres_frontend/core/httpRepo.dart';
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
    return "Token";
  }

  @override
  Future<NoParams> register(String email, String password, String name) async {
    return NoParams();
  }
}
