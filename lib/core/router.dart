import 'package:go_router/go_router.dart';
import 'package:tyres_frontend/features/Authentication/presenation/pages/loginPage.dart';
import 'package:tyres_frontend/features/Authentication/presenation/pages/registerPage.dart';
import 'package:tyres_frontend/features/Trucks/presenation/pages/TruckSearchPage.dart';
import 'package:tyres_frontend/features/Trucks/presenation/pages/ViewTruckPage.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login', // Set initial route to login
    routes: <GoRoute>[
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/trucks',
        builder: (context, state) => TruckSearchPage(),
      ),
      GoRoute(
        path: '/truck-details/:id',
        builder: (context, state) => ViewTruckPage(
          truckId: int.parse(state.pathParameters['id']!),
        ),
      ),
      // Add more routes as needed...
    ],
  );
}
