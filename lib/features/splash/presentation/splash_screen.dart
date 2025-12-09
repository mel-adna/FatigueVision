import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:fatigue_vision/config/injection.dart';
import 'package:fatigue_vision/features/onboarding/data/onboarding_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final repo = getIt<OnboardingRepository>();
    if (repo.hasSeenOnboarding) {
      context.go('/');
    } else {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.remove_red_eye_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary, // Teal
            ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 20),
            Text(
              'FATIGUE VISION',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Theme.of(context).colorScheme.onSurface, // White/Light
              ),
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.5, end: 0),
          ],
        ),
      ),
    );
  }
}
