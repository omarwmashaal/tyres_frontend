// authentication_events.dart

import 'package:equatable/equatable.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/data/models/registerModel.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event for login
class LoginEvent extends AuthenticationEvent {
  final Loginmodel loginModel;

  LoginEvent({required this.loginModel});

  @override
  List<Object?> get props => [loginModel];
}

// Event for register
class RegisterEvent extends AuthenticationEvent {
  final Registermodel registerModel;

  RegisterEvent({required this.registerModel});

  @override
  List<Object?> get props => [registerModel];
}

// Event for logging out
class LogoutEvent extends AuthenticationEvent {}
