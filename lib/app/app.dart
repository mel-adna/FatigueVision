import 'package:fatigue_vision/config/router.dart';
import 'package:fatigue_vision/core/theme/app_theme.dart';
import 'package:fatigue_vision/features/settings/presentation/settings_controller.dart';
import 'package:fatigue_vision/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final locale = ref.watch(appLocaleProvider);

    return MaterialApp.router(
      title: 'FatigueVision',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(locale ?? const Locale('en')),
      darkTheme: AppTheme.dark(locale ?? const Locale('en')),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
