import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'feature_page.dart';

class DashboardOverviewPage extends StatelessWidget {
  const DashboardOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Dashboard',
      icon: Icons.grid_view_rounded,
      accent: AppTheme.blue,
      description: 'A quick overview of what is happening in your space.',
      child: const Column(
        children: [
          _OverviewMetric(
            icon: Icons.task_alt_rounded,
            title: 'Your day is on track',
            detail: 'Everything important is in one place.',
            color: Color(0xFF12A98C),
          ),
          SizedBox(height: 12),
          _OverviewMetric(
            icon: Icons.auto_awesome_rounded,
            title: 'Make room for good work',
            detail: 'Explore your Orbit tools from the home screen.',
            color: Color(0xFF5269F5),
          ),
        ],
      ),
    );
  }
}

class _OverviewMetric extends StatelessWidget {
  const _OverviewMetric({
    required this.icon,
    required this.title,
    required this.detail,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Row(
        children: [
          Icon(icon, color: color, size: 25),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Text(detail, style: const TextStyle(color: Color(0xFF81899A))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
