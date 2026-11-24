import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'feature_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'About Us',
      icon: Icons.auto_awesome_rounded,
      accent: const Color(0xFFDF8B45),
      description: 'Thoughtful tools for a more focused day.',
      child: SurfaceCard(
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.blur_on_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Orbit',
              style: TextStyle(
                color: AppTheme.navy,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Designed to bring your everyday tools together in one clear, '
              'welcoming workspace.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF737C90), height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Version 1.0.0 • Demo',
              style: TextStyle(color: Color(0xFF9AA1AF), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
