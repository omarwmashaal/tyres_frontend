import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tyres_frontend/core/router.dart';
import 'package:tyres_frontend/core/service_injector.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_bloc.dart';
import 'package:tyres_frontend/features/Trucks/presenation/blocs/truck_bloc.dart';
import 'package:tyres_frontend/features/Tyres/presenation/blocs/tyres_bloc.dart'; // Your GetIt service injector setup

void main() async {
  // Ensuring that widgets are bound to the Flutter engine before initializing services.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetIt and all other necessary services.
  setUpServiceInjectors();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // GoRouter instance for defining routes
  final GoRouter _router = AppRouter.router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Default design size (iPhone X dimensions)
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => si<AuthenticationBloc>()),
            BlocProvider(create: (context) => si<TruckBloc>()),
            BlocProvider(create: (context) => si<TyreBloc>()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Tyres App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routerConfig: _router, // GoRouter configuration
          ),
        );
      },
    );
  }
}
