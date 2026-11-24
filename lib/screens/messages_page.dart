import 'package:flutter/material.dart';

import 'feature_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final conversations = [
      ('Orbit Team', 'Welcome aboard! Your workspace is all set.', '9:41', 'O'),
      (
        'Product Updates',
        'A fresh set of improvements is here.',
        'Yesterday',
        'P',
      ),
      ('Community', 'Say hello to your fellow Orbit members.', 'Mon', 'C'),
    ];
    return FeaturePage(
      title: 'Messages',
      icon: Icons.chat_bubble_rounded,
      accent: const Color(0xFF8270D6),
      description: 'Your conversations, collected in one calm place.',
      child: Column(
        children: [
          for (final (name, preview, time, initial) in conversations) ...[
            SurfaceCard(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFECE9FF),
                    foregroundColor: const Color(0xFF8270D6),
                    child: Text(initial),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          preview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Color(0xFF737C90)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xFF9AA1AF),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
