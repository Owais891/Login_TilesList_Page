import 'package:flutter/material.dart';

import 'screens/dashboard_page.dart';
import 'screens/login_page.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OrbitTilesApp());
}

class OrbitTilesApp extends StatefulWidget {
  const OrbitTilesApp({super.key});

  @override
  State<OrbitTilesApp> createState() => _OrbitTilesAppState();
}

class _OrbitTilesAppState extends State<OrbitTilesApp> {
  final AuthService _authService = AuthService();
  late final Future<String?> _restoredUser = _authService.restoreSession();
  String? _username;
  bool _isRestoring = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: FutureBuilder<String?>(
        future: _restoredUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const _LaunchScreen();
          }
          if (_isRestoring) {
            _username = snapshot.data;
            _isRestoring = false;
          }
          final username = _username;
          if (username == null) {
            return LoginPage(
              authService: _authService,
              onAuthenticated: (name) => setState(() => _username = name),
            );
          }
          return DashboardPage(
            username: username,
            authService: _authService,
            onLogout: () => setState(() => _username = null),
          );
        },
      ),
    );
  }
}

class _LaunchScreen extends StatelessWidget {
  const _LaunchScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
