import 'package:flutter/material.dart';

import 'feature_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePage(
      title: 'Help & Support',
      icon: Icons.support_agent_rounded,
      accent: const Color(0xFF42A66C),
      description: 'Quick answers to help you get the most out of Orbit.',
      child: const Column(
        children: [
          _HelpQuestion(
            question: 'How do I find a workspace?',
            answer: 'Use the search field on your dashboard to filter spaces by name or description.',
          ),
          SizedBox(height: 10),
          _HelpQuestion(
            question: 'Can I stay signed in?',
            answer: 'Turn on Remember me at sign-in to keep your demo session on this device.',
          ),
          SizedBox(height: 10),
          _HelpQuestion(
            question: 'How do I sign out?',
            answer: 'Open the account menu in the top-right corner of your dashboard and choose Sign out.',
          ),
        ],
      ),
    );
  }
}

class _HelpQuestion extends StatelessWidget {
  const _HelpQuestion({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 8),
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: const TextStyle(color: Color(0xFF737C90), height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
