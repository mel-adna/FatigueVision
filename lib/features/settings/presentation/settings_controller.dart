import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_controller.g.dart';
part 'settings_controller.freezed.dart'; // Add this

enum Sensitivity { low, medium, high }

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(Sensitivity.medium) Sensitivity sensitivity,
    @Default(true) bool enableAudio,
    @Default(true) bool enableVibration,
  }) = _SettingsState;
}

@riverpod
class Settings extends _$Settings {
  @override
  SettingsState build() => const SettingsState();

  void setSensitivity(Sensitivity value) {
    state = state.copyWith(sensitivity: value);
  }

  void toggleAudio(bool value) {
    state = state.copyWith(enableAudio: value);
  }

  void toggleVibration(bool value) {
    state = state.copyWith(enableVibration: value);
  }
}

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => ThemeMode.system;

  void toggle() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setTheme(ThemeMode mode) {
    state = mode;
  }
}

@riverpod
class AppLocale extends _$AppLocale {
  @override
  ui.Locale? build() => null; // null means system default

  void setLocale(ui.Locale? locale) {
    state = locale;
  }

  void toggle() {
    state = state?.languageCode == 'ar'
        ? const ui.Locale('en')
        : const ui.Locale('ar');
  }
}
