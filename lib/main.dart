import 'package:fatigue_vision/app/app.dart';
import 'package:fatigue_vision/config/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
