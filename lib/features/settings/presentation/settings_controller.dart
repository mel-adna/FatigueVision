import 'dart:async';
import 'dart:ui' as ui;

import 'package:fatigue_vision/config/providers.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';
part 'settings_controller.freezed.dart'; // Add this

enum Sensitivity { low, medium, high }

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(Sensitivity.medium) Sensitivity sensitivity,
    @Default(true) bool enableAudio,
    @Default(true) bool enableVibration,
    @Default('FatigueVision') String userName,
  }) = _SettingsState;
}

@riverpod
class Settings extends _$Settings {
  static const _kSensitivityKey = 'setting_sensitivity';
  static const _kAudioKey = 'setting_audio';
  static const _kVibrationKey = 'setting_vibration';
  static const _kUserNameKey = 'setting_username';

  @override
  SettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return SettingsState(
      sensitivity: Sensitivity
          .values[prefs.getInt(_kSensitivityKey) ?? Sensitivity.medium.index],
      enableAudio: prefs.getBool(_kAudioKey) ?? true,
      enableVibration: prefs.getBool(_kVibrationKey) ?? true,
      userName: prefs.getString(_kUserNameKey) ?? 'FatigueVision',
    );
  }

  void setSensitivity(Sensitivity value) {
    state = state.copyWith(sensitivity: value);
    final prefs = ref.read(sharedPreferencesProvider);
    unawaited(prefs.setInt(_kSensitivityKey, value.index));
  }

  void toggleAudio({required bool value}) {
    state = state.copyWith(enableAudio: value);
    final prefs = ref.read(sharedPreferencesProvider);
    unawaited(prefs.setBool(_kAudioKey, value));
  }

  void toggleVibration({required bool value}) {
    state = state.copyWith(enableVibration: value);
    final prefs = ref.read(sharedPreferencesProvider);
    unawaited(prefs.setBool(_kVibrationKey, value));
  }

  void setUserName(String name) {
    state = state.copyWith(userName: name);
    final prefs = ref.read(sharedPreferencesProvider);
    unawaited(prefs.setString(_kUserNameKey, name));
  }
}

@riverpod
class AppThemeMode extends _$AppThemeMode {
  static const _kThemeKey = 'app_theme';

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final themeString = prefs.getString(_kThemeKey);
    if (themeString == 'light') return ThemeMode.light;
    if (themeString == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  void toggle() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setTheme(newMode);
  }

  void setTheme(ThemeMode mode) {
    state = mode;
    final prefs = ref.read(sharedPreferencesProvider);
    final modeString = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    unawaited(prefs.setString(_kThemeKey, modeString));
  }
}

@riverpod
class AppLocale extends _$AppLocale {
  static const _kLocaleKey = 'app_locale';

  @override
  ui.Locale? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final languageCode = prefs.getString(_kLocaleKey);
    if (languageCode != null) {
      return ui.Locale(languageCode);
    }
    return null; // system default
  }

  void setLocale(ui.Locale? locale) {
    state = locale;
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale != null) {
      unawaited(prefs.setString(_kLocaleKey, locale.languageCode));
    } else {
      unawaited(prefs.remove(_kLocaleKey));
    }
  }

  void toggle() {
    final newLocale = state?.languageCode == 'ar'
        ? const ui.Locale('en')
        : const ui.Locale('ar');
    setLocale(newLocale);
  }
}
