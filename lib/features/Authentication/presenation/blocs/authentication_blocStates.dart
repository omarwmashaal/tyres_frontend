// authentication_states.dart

import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state, when nothing has happened yet
class AuthenticationInitialState extends AuthenticationState {}

// State when a loading process is happening
class AuthenticationLoadingState extends AuthenticationState {}

// State when login is successful
class AuthenticationLoginSuccessState extends AuthenticationState {}

// State when registration is successful
class AuthenticationRegisterSuccessState extends AuthenticationState {}

// State when logout is successful
class AuthenticationLogoutSuccessState extends AuthenticationState {}

class AuthenticationUnAuthorizedState extends AuthenticationState {}

// State when an error occurs
class AuthenticationErrorState extends AuthenticationState {
  final String message;

  AuthenticationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
