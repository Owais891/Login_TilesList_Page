import 'package:flutter/material.dart';

import 'feature_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Notifications',
      icon: Icons.notifications_rounded,
      accent: const Color(0xFFE76F83),
      description: 'A little signal when something needs your attention.',
      child: const Column(
        children: [
          _NotificationItem(
            icon: Icons.waving_hand_rounded,
            title: 'Welcome to Orbit',
            message: 'Your workspace is ready whenever you are.',
            time: 'Just now',
            color: Color(0xFF5269F5),
          ),
          SizedBox(height: 12),
          _NotificationItem(
            icon: Icons.tips_and_updates_outlined,
            title: 'A tip for your day',
            message: 'Keep your favorite spaces close at hand.',
            time: 'Earlier today',
            color: Color(0xFFEE9B32),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String message;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Text(message, style: const TextStyle(color: Color(0xFF737C90))),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF9AA1AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
