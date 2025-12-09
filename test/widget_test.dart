// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fatigue_vision/app/app.dart';
import 'package:fatigue_vision/config/injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: App()));

    // Verify that the splash screen text appears
    expect(find.text('FATIGUE VISION'), findsOneWidget);

    // Advance time for splash animation and navigation
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify we are on Onboarding screen
    expect(find.text('Welcome to FatigueVision'), findsOneWidget);
  });
}
