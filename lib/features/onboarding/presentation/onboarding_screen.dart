import 'package:fatigue_vision/config/injection.dart';
import 'package:fatigue_vision/features/onboarding/data/onboarding_repository.dart';
import 'package:fatigue_vision/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background decoration
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Icon(
                    Icons.safety_check,
                    size: 100,
                    color: Colors.blueAccent,
                  ).animate().scale(delay: 200.ms),
                  const SizedBox(height: 40),
                  Text(
                    context.l10n.onboardingTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().slideY(),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.onboardingDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await getIt<OnboardingRepository>()
                            .completeOnboarding();
                        if (context.mounted) context.go('/');
                      },
                      child: Text(
                        context.l10n.getStarted,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 1, end: 0),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
