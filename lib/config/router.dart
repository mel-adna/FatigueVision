import 'package:fatigue_vision/features/home/presentation/home_screen.dart';
import 'package:fatigue_vision/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fatigue_vision/features/splash/presentation/splash_screen.dart';
import 'package:fatigue_vision/features/settings/presentation/settings_screen.dart';
import 'package:fatigue_vision/features/fatigue/presentation/camera_screen.dart';
import 'package:fatigue_vision/features/history/presentation/history_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/camera',
        builder: (context, state) => const CameraScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
    ],
  );
});
