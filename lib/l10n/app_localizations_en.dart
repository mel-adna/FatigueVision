// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FatigueVision';

  @override
  String get onboardingTitle => 'Welcome to FatigueVision';

  @override
  String get onboardingDescription =>
      'Real-time fatigue detection for industrial safety.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get startDetection => 'Start Detection';

  @override
  String get settings => 'Settings';

  @override
  String get history => 'History';

  @override
  String get industrialMode => 'Industrial Mode';

  @override
  String get language => 'Language';

  @override
  String get reset => 'Reset';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get fatigueLevel => 'Fatigue Level';

  @override
  String get normal => 'Normal';

  @override
  String get drowsy => 'Drowsy';

  @override
  String get alert => 'ALERT!';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get notifications => 'Notifications';
}
