// authentication_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tyres_frontend/core/failure.dart';
import 'package:tyres_frontend/core/usecase/usecases.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_login.dart';
import 'package:tyres_frontend/features/Authentication/domain/usecases/usaeCase_register.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocEvents.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocStates.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthenticationBloc({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(AuthenticationInitialState()) {
    // Handle login event
    on<LoginEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      final Either<Failure, NoParams> result = await loginUseCase(event.loginModel);
      result.fold(
        (failure) => emit(AuthenticationErrorState(message: failure.message)),
        (token) => emit(AuthenticationLoginSuccessState()),
      );
    });

    // Handle register event
    on<RegisterEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      final Either<Failure, NoParams> result = await registerUseCase(event.registerModel);
      result.fold(
        (failure) => emit(AuthenticationErrorState(message: failure.message)),
        (_) => emit(AuthenticationRegisterSuccessState()),
      );
    });

    // Handle logout event
    on<LogoutEvent>((event, emit) async {
      emit(AuthenticationLoadingState());
      // Assuming logout does some async operation, e.g., clearing local storage
      await Future.delayed(Duration(seconds: 1)); // Simulate a delay for logout
      emit(AuthenticationLogoutSuccessState());
    });
  }
}
