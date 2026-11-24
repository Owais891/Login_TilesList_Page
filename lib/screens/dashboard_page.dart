import 'package:flutter/material.dart';

import '../models/tile_model.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_tile.dart';
import 'about_page.dart';
import 'dashboard_overview_page.dart';
import 'help_page.dart';
import 'messages_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'reports_page.dart';
import 'settings_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    required this.username,
    required this.authService,
    required this.onLogout,
    super.key,
  });

  final String username;
  final AuthService authService;
  final VoidCallback onLogout;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _searchController = TextEditingController();
  String _query = '';
  bool _isLoggingOut = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TileModel> get _filteredTiles => TileModel.items
      .where(
        (tile) =>
            tile.title.toLowerCase().contains(_query) ||
            tile.description.toLowerCase().contains(_query),
      )
      .toList();

  void _openTile(TileModel tile) {
    final Widget page = switch (tile.id) {
      'dashboard' => const DashboardOverviewPage(),
      'profile' => ProfilePage(username: widget.username),
      'settings' => const SettingsPage(),
      'notifications' => const NotificationsPage(),
      'messages' => const MessagesPage(),
      'reports' => const ReportsPage(),
      'help' => const HelpPage(),
      'about' => const AboutPage(),
      _ => const DashboardOverviewPage(),
    };
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  Future<void> _logout() async {
    setState(() => _isLoggingOut = true);
    try {
      await widget.authService.signOut();
      if (mounted) widget.onLogout();
    } on Exception {
      if (!mounted) return;
      setState(() => _isLoggingOut = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not sign out. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1000
        ? 4
        : width >= 650
        ? 3
        : 2;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Row(
          children: [
            _OrbitMark(size: 34),
            SizedBox(width: 10),
            Text(
              'orbit',
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.3),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Account menu',
            icon: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFE7EBFF),
              child: Text(
                widget.username.characters.first.toUpperCase(),
                style: const TextStyle(
                  color: AppTheme.blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onSelected: (value) {
              if (value == 'profile') {
                _openTile(TileModel.items[1]);
              } else if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: const ListTile(
                  leading: Icon(Icons.person_outline_rounded),
                  title: Text('My profile'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                enabled: !_isLoggingOut,
                child: ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: Text(_isLoggingOut ? 'Signing out…' : 'Sign out'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 30),
          children: [
            Text(
              'YOUR SPACE',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.blue,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Good to see you, ${widget.username.split(' ').first}.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.navy,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Everything you need, right where you need it.',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: const Color(0xFF81899A)),
            ),
            const SizedBox(height: 22),
            TextField(
              controller: _searchController,
              onChanged: (value) =>
                  setState(() => _query = value.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Search your workspace',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Explore',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.navy,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_filteredTiles.length} spaces',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: const Color(0xFF8A91A1)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (_filteredTiles.isEmpty)
              const _EmptySearch()
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredTiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  childAspectRatio: columns == 2 ? 0.78 : 0.86,
                ),
                itemBuilder: (context, index) {
                  final tile = _filteredTiles[index];
                  return DashboardTile(
                    tile: tile,
                    onTap: () => _openTile(tile),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _OrbitMark extends StatelessWidget {
  const _OrbitMark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppTheme.blue,
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(
        Icons.blur_on_rounded,
        color: Colors.white,
        size: size * 0.72,
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDF0F6)),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off_rounded, size: 34, color: Color(0xFF9AA2B3)),
          SizedBox(height: 10),
          Text(
            'No spaces found',
            style: TextStyle(color: AppTheme.navy, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4),
          Text(
            'Try a different search term.',
            style: TextStyle(color: Color(0xFF81899A)),
          ),
        ],
      ),
    );
  }
}
