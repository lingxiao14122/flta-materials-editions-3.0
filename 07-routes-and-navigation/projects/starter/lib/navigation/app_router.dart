
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;

  AppRouter(this.appStateManager, this.profileManager, this.groceryManager);

  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: appStateManager,
    initialLocation: '/login',
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // TODO: Add Home Route
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
    redirect: (state) {
      // 1
      final loggedIn = appStateManager.isLoggedIn;
      // 2
      final loggingIn = state.subloc == '/login';
      // 3
      if (!loggedIn) return loggingIn ? null : '/login';

      // 4
      final isOnboardingComplete = appStateManager.isOnboardingComplete;
      // 5
      final onboarding = state.subloc == '/onboarding';
      // 6
      if (!isOnboardingComplete) {
        return onboarding ? null : '/onboarding';
      }
      // 7
      if (loggingIn || onboarding) return '/${FooderlichTab.explore}';
      // 8
      return null;
    },

  );
}
