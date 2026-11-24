import 'package:flutter/material.dart';

class TileModel {
  const TileModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  static const items = <TileModel>[
    TileModel(
      id: 'dashboard',
      title: 'Dashboard',
      description: 'Your workspace at a glance',
      icon: Icons.grid_view_rounded,
      color: Color(0xFF5269F5),
    ),
    TileModel(
      id: 'profile',
      title: 'Profile',
      description: 'Manage your personal details',
      icon: Icons.person_rounded,
      color: Color(0xFF12A98C),
    ),
    TileModel(
      id: 'settings',
      title: 'Settings',
      description: 'Make Orbit work for you',
      icon: Icons.tune_rounded,
      color: Color(0xFFEE9B32),
    ),
    TileModel(
      id: 'notifications',
      title: 'Notifications',
      description: 'Stay in the know',
      icon: Icons.notifications_rounded,
      color: Color(0xFFE76F83),
    ),
    TileModel(
      id: 'messages',
      title: 'Messages',
      description: 'Conversations, all in one place',
      icon: Icons.chat_bubble_rounded,
      color: Color(0xFF8270D6),
    ),
    TileModel(
      id: 'reports',
      title: 'Reports',
      description: 'Insights that move you forward',
      icon: Icons.insert_chart_rounded,
      color: Color(0xFF3297D3),
    ),
    TileModel(
      id: 'help',
      title: 'Help & Support',
      description: 'We are here when you need us',
      icon: Icons.support_agent_rounded,
      color: Color(0xFF42A66C),
    ),
    TileModel(
      id: 'about',
      title: 'About Us',
      description: 'A little more about Orbit',
      icon: Icons.auto_awesome_rounded,
      color: Color(0xFFDF8B45),
    ),
  ];
}
