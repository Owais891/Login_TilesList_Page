import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'feature_page.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Reports',
      icon: Icons.insert_chart_rounded,
      accent: const Color(0xFF3297D3),
      description: 'A snapshot of your progress and activity.',
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: _ReportMetric(
                  value: '12',
                  label: 'Items completed',
                  icon: Icons.task_alt_rounded,
                  color: Color(0xFF12A98C),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ReportMetric(
                  value: '84%',
                  label: 'Weekly focus',
                  icon: Icons.bolt_rounded,
                  color: Color(0xFF5269F5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This week',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.72,
                    minHeight: 10,
                    backgroundColor: Color(0xFFE9EDF7),
                    color: Color(0xFF3297D3),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'You’re building a great rhythm. Keep it up!',
                  style: TextStyle(color: Color(0xFF737C90)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportMetric extends StatelessWidget {
  const _ReportMetric({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.navy,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Color(0xFF81899A))),
        ],
      ),
    );
  }
}
