import 'package:get_it/get_it.dart';
import 'package:tyres_frontend/core/httpRepo.dart';
import 'package:tyres_frontend/features/Authentication/data/datasource/authentication_datasource.dart';
import 'package:tyres_frontend/features/Authentication/data/repoImpl/authenticationRepoImpl.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_login.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_register.dart';
import 'package:tyres_frontend/features/Trucks/data/datasource/truckDatasource.dart';
import 'package:tyres_frontend/features/Trucks/data/repoImpl/truckRepoImpl.dart';
import 'package:tyres_frontend/features/Trucks/domain/repo/truckRepo.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_addTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_getTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_removeTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_searchTrucks.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_updateTruck.dart';

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

  //?Trucks
  //datsources
  si.registerLazySingleton<Truckdatasource>(() => TruckDatasourceImpl(httpRepo: si()));
  //repo
  si.registerLazySingleton<Truckrepo>(() => Truckrepoimpl(truckdatasource: si()));
  //usecases
  si.registerLazySingleton(() => RemoveTruckUseCase(truckrepo: si()));
  si.registerLazySingleton(() => SearchTrucksUseCase(truckrepo: si()));
  si.registerLazySingleton(() => AddTruckUseCase(truckrepo: si()));
  si.registerLazySingleton(() => UpdateTruckUseCase(truckrepo: si()));
  si.registerLazySingleton(() => GetTruckUseCase(truckrepo: si()));
}
