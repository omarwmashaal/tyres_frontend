import 'package:get_it/get_it.dart';
import 'package:tyres_frontend/core/httpRepo.dart';
import 'package:tyres_frontend/features/Authentication/data/datasource/authentication_datasource.dart';
import 'package:tyres_frontend/features/Authentication/data/repoImpl/authenticationRepoImpl.dart';
import 'package:tyres_frontend/features/Authentication/domain/repo/authenticationRepo.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_login.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_register.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_bloc.dart';
import 'package:tyres_frontend/features/Trucks/data/datasource/truckDatasource.dart';
import 'package:tyres_frontend/features/Trucks/data/repoImpl/truckRepoImpl.dart';
import 'package:tyres_frontend/features/Trucks/domain/repo/truckRepo.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_addTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_getTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_removeTruck.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_searchTrucks.dart';
import 'package:tyres_frontend/features/Trucks/domain/usecases/usaeCase_updateTruck.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Tyres/data/datasource/tyreDatasource.dart';
import 'package:tyres_frontend/features/Tyres/data/repoImpl/tyreRepoImpl.dart';
import 'package:tyres_frontend/features/Tyres/domain/repo/tyresRepo.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/AddTyreUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/ChangeTyrePositionUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/DeleteTyreUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/GetTyreBySerialUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/InstallTyreToATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/RemoveTyreFromATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/getTyreData_usecase.dart';
import 'package:tyres_frontend/features/Tyres/domain/usecases/getTyresForATruckUseCase.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';

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
  //?blocs
  si.registerLazySingleton(() => AuthenticationBloc(
        loginUseCase: si(),
        registerUseCase: si(),
      ));
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
  //blocs
  si.registerLazySingleton(() => TruckBloc(
        addTruckUseCase: si(),
        getTruckUseCase: si(),
        removeTruckUseCase: si(),
        searchTrucksUseCase: si(),
        updateTruckUseCase: si(),
      ));

  //?Tyres
  //datsources
  si.registerLazySingleton<TyreDatasource>(() => TyreDatasourceImpl(httpRepo: si()));
  //repo
  si.registerLazySingleton<TyresRepo>(() => TyresRepoImpl(tyreDatasource: si()));
  //usecases
  si.registerLazySingleton(() => AddTyreUseCase(tyresRepo: si()));
  si.registerLazySingleton(() => ChangeTyrePositionUseCase(tyresRepo: si()));
  si.registerLazySingleton(() => DeleteTyreUseCase(tyresRepo: si()));
  si.registerLazySingleton(() => GetTyreBySerialUseCase(tyresRepo: si()));
  si.registerLazySingleton(() => GetTyreDataUseCase(tyresRepo: si()));
  si.registerLazySingleton(() => GetTyresForATruckUseCase(tyresRepo: si()));
  si.registerLazySingleton(() => InstallTyreToATruckUseCase(tyresRepo: si()));
  si.registerLazySingleton(() => RemoveTyreFromATruckUseCase(tyresRepo: si()));
  //?blocs
  si.registerLazySingleton(() => TyreBloc(
        addTyreUseCase: si(),
        changeTyrePositionUseCase: si(),
        deleteTyreUseCase: si(),
        getTyreBySerialUseCase: si(),
        getTyresForATruckUseCase: si(),
        installTyreToATruckUseCase: si(),
        removeTyreFromATruckUseCase: si(),
        getTyreDataUseCase: si(),
      ));
}
