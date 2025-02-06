import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tyres_frontend/core/Widgets/globalAuthBloc.dart';
import 'package:tyres_frontend/core/router.dart';
import 'package:tyres_frontend/core/service_injector.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_bloc.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocStates.dart';
import 'package:tyres_frontend/features/Authentication/presenation/pages/loginPage.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'core/remoteConstats.dart'; // Your GetIt service injector setup

void main() async {
  // Ensuring that widgets are bound to the Flutter engine before initializing services.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetIt and all other necessary services.
  await setUpServiceInjectors();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // GoRouter instance for defining routes
  final GoRouter _router = AppRouter.router;

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      duration: Durations.medium4,
      reverseDuration: Durations.medium4,
      overlayColor: Colors.grey.withValues(alpha: 0.8),
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return Center(child: CircularProgressIndicator());
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => si<AuthenticationBloc>()),
          BlocProvider(create: (context) => si<TruckBloc>()),
          BlocProvider(create: (context) => si<TyreBloc>()),
          BlocProvider(create: (context) => si<Globalauthbloc>()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            globalauthbloc = BlocProvider.of<Globalauthbloc>(context);
            return MaterialApp(
              home: LoginPage(),
            );
          },
        ),
      ),
    );
  }
}
