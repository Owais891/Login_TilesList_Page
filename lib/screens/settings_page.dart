import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import 'feature_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _weeklySummary = false;
  bool _biometrics = false;

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Settings',
      icon: Icons.tune_rounded,
      accent: const Color(0xFFEE9B32),
      description: 'A few thoughtful choices to make Orbit yours.',
      child: SurfaceCard(
        child: Column(
          children: [
            _SettingSwitch(
              icon: Icons.notifications_outlined,
              title: 'Push notifications',
              value: _notifications,
              onChanged: (value) => setState(() => _notifications = value),
            ),
            const Divider(height: 25),
            _SettingSwitch(
              icon: Icons.calendar_month_outlined,
              title: 'Weekly summary',
              value: _weeklySummary,
              onChanged: (value) => setState(() => _weeklySummary = value),
            ),
            const Divider(height: 25),
            _SettingSwitch(
              icon: Icons.fingerprint_rounded,
              title: 'Biometric sign-in',
              value: _biometrics,
              onChanged: (value) {
                HapticFeedback.selectionClick();
                setState(() => _biometrics = value);
              },
            ),
            const SizedBox(height: 18),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'These demo preferences apply for this session.',
                style: TextStyle(color: Color(0xFF81899A), fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingSwitch extends StatelessWidget {
  const _SettingSwitch({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.blue, size: 21),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
