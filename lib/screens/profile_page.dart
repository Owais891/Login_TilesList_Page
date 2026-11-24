import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'feature_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.username, super.key});

  final String username;

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Profile',
      icon: Icons.person_rounded,
      accent: const Color(0xFF12A98C),
      description: 'Your account details and personal preferences.',
      child: Column(
        children: [
          SurfaceCard(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: const Color(0xFFE7EBFF),
                  child: Text(
                    username.characters.first.toUpperCase(),
                    style: const TextStyle(
                      color: AppTheme.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  username,
                  style: const TextStyle(
                    color: AppTheme.navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Orbit member',
                  style: TextStyle(color: Color(0xFF81899A)),
                ),
                const SizedBox(height: 18),
                const Divider(height: 1),
                const _ProfileDetail(
                  icon: Icons.alternate_email_rounded,
                  label: 'Email',
                  value: 'demo@orbit.app',
                ),
                const _ProfileDetail(
                  icon: Icons.verified_user_outlined,
                  label: 'Account type',
                  value: 'Demo account',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetail extends StatelessWidget {
  const _ProfileDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        children: [
          Icon(icon, size: 19, color: const Color(0xFF858DA0)),
          const SizedBox(width: 11),
          Text(label, style: const TextStyle(color: Color(0xFF81899A))),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.navy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
