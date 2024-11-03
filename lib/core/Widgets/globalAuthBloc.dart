import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocStates.dart';

class Globalauthbloc extends Cubit<AuthenticationState> {
  Globalauthbloc() : super(AuthenticationInitialState());
}
