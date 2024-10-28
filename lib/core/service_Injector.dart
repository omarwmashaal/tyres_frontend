import 'package:get_it/get_it.dart';
import 'package:tyres_frontend/core/httpRepo.dart';
import 'package:tyres_frontend/features/Authentication/data/datasource/authentication_datasource.dart';
import 'package:tyres_frontend/features/Authentication/data/repoImpl/authenticationRepoImpl.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_login.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_register.dart';

var si = GetIt.instance;

setUpServiceInjectors() {
  //?core
  si.registerLazySingleton<HttpRepo>(() => HttpClientImpl());

  //?Authentication
  //datsources
  si.registerLazySingleton<AuthenticationDatasource>(() => AuthenticationDatasourceImpl(httpRepo: si()));
  //repo
  si.registerLazySingleton<Authenticationrepo>(() => Authenticationrepoimpl(authenticationDatasource: si()));
  //usecases
  si.registerLazySingleton(() => LoginUseCase(authenticationrepo: si()));
  si.registerLazySingleton(() => RegisterUseCase(authenticationrepo: si()));
}
