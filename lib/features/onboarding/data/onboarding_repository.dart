import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
@injectable
class OnboardingRepository {
  OnboardingRepository(this._prefs);

  final SharedPreferences _prefs;
  static const String _key = 'has_seen_onboarding';

  bool get hasSeenOnboarding => _prefs.getBool(_key) ?? false;

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_key, true);
  }
}
