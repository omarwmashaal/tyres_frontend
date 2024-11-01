import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tyres_frontend/features/Authentication/presenation/pages/loginPage.dart';
import 'package:tyres_frontend/features/Authentication/presenation/pages/registerPage.dart';
import 'package:tyres_frontend/features/Trucks/presenation/pages/TruckSearchPage.dart';
import 'package:tyres_frontend/features/Trucks/presenation/pages/ViewTruckPage.dart';
import 'package:tyres_frontend/features/Tyres/presenation/pages/TyreSearchPage.dart';

var navBarIndex = 0.obs;

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login', // Set initial route to login
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: navBarIndex.value,
                onTap: (value) {
                  navBarIndex.value = value;
                  if (value == 0)
                    context.go('/trucks');
                  else if (value == 1) context.go('/tyres');
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.fire_truck),
                    label: "Trucks",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.circle),
                    label: "Tyres",
                  ),
                ],
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/trucks',
            builder: (context, state) => TruckSearchPage(),
          ),
          GoRoute(
            path: '/tyres',
            builder: (context, state) => TyreSearchPage(),
          ),
        ],
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
