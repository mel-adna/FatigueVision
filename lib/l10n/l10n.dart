import 'package:flutter/widgets.dart';
import 'package:fatigue_vision/l10n/app_localizations.dart';

export 'package:fatigue_vision/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
