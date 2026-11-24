import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FeaturePage extends StatelessWidget {
  const FeaturePage({
    required this.title,
    required this.icon,
    required this.accent,
    required this.description,
    required this.child,
    super.key,
  });

  final String title;
  final IconData icon;
  final Color accent;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 32),
        children: [
          Container(
            width: 68,
            height: 68,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(icon, size: 34, color: accent),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(color: AppTheme.navy, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 7),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: const Color(0xFF81899A), height: 1.5),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDF0F6)),
      ),
      child: child,
    );
  }
}
