// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'رؤية الإجهاد';

  @override
  String get onboardingTitle => 'مرحبا بك في رؤية الإجهاد';

  @override
  String get onboardingDescription =>
      'كشف الإجهاد في الوقت الحقيقي للسلامة الصناعية.';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get startDetection => 'ابدأ الكشف';

  @override
  String get settings => 'الإعدادات';

  @override
  String get history => 'السجل';

  @override
  String get industrialMode => 'الوضع الصناعي';

  @override
  String get language => 'اللغة';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get fatigueLevel => 'مستوى الإجهاد';

  @override
  String get normal => 'طبيعي';

  @override
  String get drowsy => 'نعاس';

  @override
  String get alert => 'تنبيه!';

  @override
  String get exportPdf => 'تصدير PDF';

  @override
  String get notifications => 'الإشعارات';
}
