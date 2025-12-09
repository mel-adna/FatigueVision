import 'package:fatigue_vision/features/settings/presentation/settings_controller.dart';
import 'package:fatigue_vision/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final locale = ref.watch(appLocaleProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(context.l10n.settings),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSection(
              context,
              title: 'Appearance',
              children: [
                _buildSwitchTile(
                  context,
                  title: 'Dark Mode',
                  subtitle: 'Use darker colors for low-light',
                  icon: Icons.dark_mode,
                  value:
                      themeMode == ThemeMode.dark ||
                      (themeMode == ThemeMode.system &&
                          MediaQuery.of(context).platformBrightness ==
                              Brightness.dark),
                  onChanged: (val) {
                    ref
                        .read(appThemeModeProvider.notifier)
                        .setTheme(val ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
                const Divider(height: 1, indent: 56),
                _buildActionTile(
                  context,
                  title: context.l10n.language,
                  subtitle: locale?.languageCode == 'ar' ? 'Arabic' : 'English',
                  icon: Icons.language,
                  onTap: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        final currentLang = locale?.languageCode ?? 'en';
                        return Dialog(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.language,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                _buildLanguageOption(
                                  context,
                                  title: 'English',
                                  value: 'en',
                                  groupValue: currentLang,
                                  onConnect: () => ref
                                      .read(appLocaleProvider.notifier)
                                      .setLocale(const Locale('en')),
                                ),
                                _buildLanguageOption(
                                  context,
                                  title: 'Arabic',
                                  value: 'ar',
                                  groupValue: currentLang,
                                  onConnect: () => ref
                                      .read(appLocaleProvider.notifier)
                                      .setLocale(const Locale('ar')),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'Detection',
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  title: const Text('Sensitivity'),
                  subtitle: Text(
                    ref.watch(settingsProvider).sensitivity.name.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  leading: Icon(
                    Icons.speed,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface, // Inner
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Sensitivity>(
                        value: ref.watch(settingsProvider).sensitivity,
                        icon: const Icon(Icons.arrow_drop_down),
                        isDense: true,
                        onChanged: (val) {
                          if (val != null) {
                            ref
                                .read(settingsProvider.notifier)
                                .setSensitivity(val);
                          }
                        },
                        items: Sensitivity.values.map((s) {
                          return DropdownMenuItem(
                            value: s,
                            child: Text(s.name.toUpperCase()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, indent: 56),
                _buildSwitchTile(
                  context,
                  title: 'Audio Alerts',
                  subtitle: null,
                  icon: Icons.volume_up,
                  value: ref.watch(settingsProvider).enableAudio,
                  onChanged: (val) =>
                      ref.read(settingsProvider.notifier).toggleAudio(val),
                ),
                const Divider(height: 1, indent: 56),
                _buildSwitchTile(
                  context,
                  title: 'Vibration Alerts',
                  subtitle: null,
                  icon: Icons.vibration,
                  value: ref.watch(settingsProvider).enableVibration,
                  onChanged: (val) =>
                      ref.read(settingsProvider.notifier).toggleVibration(val),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color:
                Theme.of(context).cardTheme.color ??
                Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      secondary: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required String value,
    required String groupValue,
    required VoidCallback onConnect,
  }) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () {
        onConnect();
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
